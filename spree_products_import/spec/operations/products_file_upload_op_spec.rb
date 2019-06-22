require 'spec_helper'

RSpec.describe ProductsFileUploadOp do
  include_context 'test csv file'
  subject(:operation) { described_class }

  before(:example) do
    @file_upload_op = operation.submit(io: test_file)
  end

  it 'stores csv file inside the public/uploads directory' do
    expect(@file_upload_op.path).to exist
  end
end