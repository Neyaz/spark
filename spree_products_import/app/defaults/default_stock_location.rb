require 'singleton'

class DefaultStockLocation
  include Singleton

  def self.object
    Spree::StockLocation.find_by(name: 'default')
  end
end
