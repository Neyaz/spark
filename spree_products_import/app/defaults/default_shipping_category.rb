require 'singleton'

class DefaultShippingCategory
  include Singleton

  def self.object
    Spree::ShippingCategory.find_by(name: 'Default')
  end
end
