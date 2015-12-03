describe 'Lr::Blob' do
  it 'should initialize with contents' do
    contents = 'FAFASD'
    blob = Lr::Blob.new(contents)
    blob.contents.should == contents
  end

  it 'should preserve contents through roundtrip' do
    contents = 'FAFASD'
    blob = Lr::Blob.from_data(Lr::Blob.new(contents).to_data)
    blob.contents.should == contents
  end
end
