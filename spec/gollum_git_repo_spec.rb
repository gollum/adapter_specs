require 'spec_helper'

describe Gollum::Git::Repo do

  before(:each) do
    @repo = Gollum::Git::Repo.new(fixture('dot_bare_git'), :is_bare => true)
  end
  
  it "should have a path method" do
    @repo.should respond_to(:path)
  end

  it "should return a Gollum::Git::Git object for Repo#git" do
    @repo.git.should be_a Gollum::Git::Git
  end

  it "should return an array of Gollum::Git::Commit objects for Repo#commits" do
    @repo.commits.should be_a Array
    @repo.commits.each{|commit| commit.should be_a Gollum::Git::Commit}
  end

  it "should return a Gollum::Git::Ref object for Repo#head" do
    @repo.head.should be_a Gollum::Git::Ref
  end

  it "should have a diff method" do
    @repo.should respond_to(:diff).with(3).arguments
  end

end