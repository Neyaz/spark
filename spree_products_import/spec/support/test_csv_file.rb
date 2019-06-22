shared_context 'test csv file' do
  let(:test_file) do
    fixture_file_upload('spec/fixtures/sample.csv', 'text/csv')
  end
end