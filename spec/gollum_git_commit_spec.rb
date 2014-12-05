require 'spec_helper'

describe Gollum::Git::Commit do
  before(:each) do
    @repo = Gollum::Git::Repo.new(fixture('dot_bare_git'), :is_bare => true)
    @commit = @repo.commits.first
  end

  it "should have an id, author, authored date, and a message" do
    @commit.should respond_to(:id)
    @commit.should respond_to(:author)
    @commit.should respond_to(:authored_date)
    @commit.should respond_to(:message)
  end

  it "should return a Gollum::Git::Actor object for author" do
    @commit.author.should be_a Gollum::Git::Actor
  end

  it "should print the id with to_s" do
    @commit.to_s.should == @commit.id
  end

  it "should have stats" do
    @commit.stats.files.should include(["PURE_TODO", 32, 0, 32])
  end

  it "should return a single Gollum::Git::Tree object for Commit#tree" do
    @commit.tree.should be_a Gollum::Git::Tree
  end
  
end
