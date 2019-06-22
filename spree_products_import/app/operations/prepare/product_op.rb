module Prepare
  class ProductOp < ::Subroutine::Op
    field :hash

    validates :hash, presence: true

    outputs :object

    def perform
      object = Spree::Product.new(product_hash)
      output :object, object
    end

    private

    def product_hash
      {
        name: hash[:name],
        description: hash[:description],
        slug: hash[:slug],
        shipping_category: DefaultShippingCategory.object,
        price: hash[:price].tr(',', '.').to_f,
        sku: hash[:slug].upcase,
        available_on: hash[:availability_date]
      }
    end
  end
end
