describe 'Rvc::Commit' do
  it 'should initialize with a parent, username, message, tree sha and timestamp' do
    t = Time.now
    commit = Rvc::Commit.new('123', 'randsina', 'asdf', 'tree1', t)
    expect(commit.parent_sha).to eq('123')
    expect(commit.username).to eq('randsina')
    expect(commit.message).to eq('asdf')
    expect(commit.tree_sha).to eq('tree1')
    expect(commit.created_at).to eq(t)
  end

  describe 'from_data' do
    it 'all data should survive roundtrip' do
      t = Time.now - 1000
      c = Rvc::Commit.from_data(Rvc::Commit.new(nil, 'randsina', 'asdf', 'tree1', t).to_data)
      c.parent_sha.should be_nil
      expect(c.username).to eq('randsina')
      expect(c.message).to eq('asdf')
      expect(c.tree_sha).to eq('tree1')
      expect(c.created_at.to_s).to eq(t.to_s)
    end
  end
end
