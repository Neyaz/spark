require 'spec_helper'

RSpec.describe BulkInsertOp do
  subject(:operation) { described_class }

  let(:data) { (1...3).map { create(:product) }}

  it 'inserts objects' do
    expect { operation.submit(data: data)}.to(
      change { Spree::Product.count }
    )
  end
end