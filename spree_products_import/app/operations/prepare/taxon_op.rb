module Prepare
  class TaxonOp < ::Subroutine::Op
    field :hash

    validates :hash, presence: true

    outputs :object

    def perform
      object = Spree::Taxon.new(category_hash)
      output :object, object
    end

    private

    def category_hash
      {
        name: hash[:category],
        parent_id: DefaultCategory.object.id
      }
    end
  end
end
