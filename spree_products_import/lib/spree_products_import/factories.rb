FactoryBot.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_products_import/factories'
  factory :default_shipping_category, class: 'Spree::ShippingCategory' do
    name { 'Default' }
  end
  factory :default_stock_location, class: 'Spree::StockLocation' do
    name { 'default' }
  end
  factory :default_taxon, class: 'Spree::Taxon' do
    name { 'Categories' }
  end
end
