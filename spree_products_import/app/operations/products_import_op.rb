require 'csv'

class ProductsImportOp < ::Subroutine::Op
  field :path

  validates :path, presence: true

  CSV_OPTIONS = {
    headers: true,
    col_sep: ';',
    header_converters: :symbol
  }.freeze

  outputs :result

  def perform
    category_names, categories, products, stock_items = proceed_data
    ActiveRecord::Base.transaction do
      BulkInsertOp.submit(
        model: Spree::Taxon,
        data: categories
      )
      result = BulkInsertOp.submit(
        model: Spree::Product,
        data: add_categories_to_products(products, category_names)
      ).result
      variants = variants_by_products(result.ids)
      BulkInsertOp.submit(
        model: Spree::StockItem,
        data: stock_items.each.with_index { |item, i| item.variant = variants[i] }
      )
    end

    output :result, result
  end

  private

  def csv_hash
    CSV.foreach(path, CSV_OPTIONS)
       .map { |line| line.to_h.compact }
       .delete_if(&:empty?)
  end

  def proceed_data
    category_names = []
    categories = []
    products = []
    stock_items = []
    csv_hash.map do |line|
      next if product_exist?(line[:slug])

      category_names << line[:category]
      categories << Prepare::TaxonOp.submit!(hash: line).object unless category_exist?(line[:category])
      products << Prepare::ProductOp.submit!(hash: line).object
      stock_items << Prepare::StockItemOp.submit!(hash: line).object
    end
    [category_names, categories.uniq(&:name), products, stock_items]
  end

  def existing_categories
    @existing_categories ||= Spree::Taxon.pluck(:name)
  end

  def category_exist?(category_name)
    existing_categories.include?(category_name)
  end

  def existing_products
    @existing_products ||= Spree::Product.pluck(:slug)
  end

  def product_exist?(slug)
    existing_products.include?(slug)
  end

  def category(category_name)
    Spree::Taxon.find_by(name: category_name)
  end

  def variants_by_products(ids)
    Spree::Variant.where(product_id: ids)
  end

  def add_categories_to_products(products, category_names)
    products.each
            .with_index{
              |product, i| product.taxons << category(category_names[i])
            }
  end
end
