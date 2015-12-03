describe 'Lr::Log' do
  def log
    Lr::Log.new(Lr::Repo.new(test_repo1_dir))
  end

  it 'should be valid with a Repo' do
    Lr::Log.new(Lr::Repo.new(test_repo1_dir))
  end

  it 'should be invalid without a Repo' do
    -> { Lr::Log.new(1) }.should raise_error(RuntimeError, 'Log needs a Repo'.colorize(:red))
  end

  it 'should return an empty log for an uninitialized repo' do
    log.to_s.should == 'No commits.'.colorize(:green)
  end
end
