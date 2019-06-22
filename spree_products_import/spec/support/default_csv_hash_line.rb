shared_context 'default csv hash line' do
  let(:default_csv_hash_line) do
    {
      name: FFaker::Product.product_name,
      description: FFaker::Lorem,
      slug: FFaker::Product.product_name,
      price: rand(0.1...100.0).round(2).to_s,
      availability_date: FFaker::Time.datetime,
      stock_total: Random.rand(20),
      category: FFaker::Product.brand
    }
  end
end