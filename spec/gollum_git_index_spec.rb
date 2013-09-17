require 'spec_helper'

describe Gollum::Git::Index do
  before(:each) do
    @repo = Gollum::Git::Repo.new(fixture('dot_bare_git'), :is_bare => true)
    @index = @repo.index
  end

  it "should respond to add, delete and commit" do
    @index.should respond_to(:add).with(2).arguments
    @index.should respond_to(:delete).with(1).argument
    @index.should respond_to(:commit).with(1).argument
    @index.should respond_to(:commit).with(5).arguments
  end

  it "should return a Gollum::Git::Tree for Index#tree" do
    @index.tree.should be_a Gollum::Git::Tree
  end

  it "should have a read_tree method" do
    @index.should respond_to(:read_tree).with(1).argument
  end

  it "should load the current tree with Index#read_tree" do
    @index.current_tree.should be_nil 
    @index.read_tree(@repo.head.commit.id)
    @index.current_tree.should_not be_nil
  end

  it "should return a Gollum::Git::Tree for Index#current_tree" do
    @index.read_tree(@repo.head.commit.id)
    @index.current_tree.should be_a Gollum::Git::Tree
  end

end