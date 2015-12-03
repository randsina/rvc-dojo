describe 'Lr::Tree' do
  it 'should initialize with a list of type, sha, name tuples' do
    contents = [%w(tree 123 lib), %w(blob 4589 README)]
    tree = Lr::Tree.new(contents)
    tree.contents.should == contents
  end

  it 'should preserve contents through roundtrip' do
    contents = [%w(tree 123 lib), %w(blob 4589 README)]
    tree = Lr::Tree.from_data(Lr::Tree.new(contents).to_data)
    tree.contents.should == contents
  end
end
