require 'spec_helper'

describe Gollum::Git::Ref do
  before(:each) do
    @repo = Gollum::Git::Repo.new(fixture('dot_bare_git'), :is_bare => true)
    @ref = @repo.head
  end

  it "should have a name method" do
    @ref.should respond_to(:name)
  end

  it "should return a Gollum::Git::Commit for Ref#commit" do
    @ref.commit.should be_a Gollum::Git::Commit
  end
end