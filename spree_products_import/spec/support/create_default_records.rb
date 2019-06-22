shared_context 'create default records' do
  before(:example) do
    create(:default_shipping_category)
    create(:default_stock_location)
    create(:default_taxon)
  end
end