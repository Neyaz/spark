module Prepare
  class StockItemOp < ::Subroutine::Op
    field :hash

    validates :hash, presence: true

    outputs :object

    def perform
      object = Spree::StockItem.new(stock_item_hash)
      output :object, object
    end

    private

    def stock_item_hash
      {
        count_on_hand: hash[:stock_total],
        stock_location_id: DefaultStockLocation.object.id,
      }
    end
  end
end
