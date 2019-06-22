require 'spec_helper'

RSpec.describe ProductsImportOp do
  include_context 'create default records'
  include_context 'test csv file'
  subject(:operation) { described_class }

  it 'imports products and variants' do
    expect { operation.submit!(path: test_file) }.to(
      change { Spree::Product.count }
      .and(change { Spree::Variant.count })
      .and(change { Spree::StockItem.count })
    )
  end
end