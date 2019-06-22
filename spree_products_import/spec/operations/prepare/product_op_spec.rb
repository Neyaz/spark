require 'spec_helper'

RSpec.describe Prepare::ProductOp do
  include_context 'create default records'
  include_context 'default csv hash line'
  subject(:operation) { described_class }

  let(:product_class) { Spree::Product }

  before(:example) do
    @product_op = operation.submit(hash: default_csv_hash_line)
  end

  it 'returns new Spree::Product object' do
    expect(@product_op.object).to be_an_instance_of(product_class)
  end
end