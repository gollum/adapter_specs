require 'spec_helper'

describe Gollum::Git::Tree do
  before(:each) do
    @repo = Gollum::Git::Repo.new(fixture('dot_bare_git'), :is_bare => true)
    @repo.index.read_tree(@repo.head.commit.tree.id)
    @tree = @repo.index.current_tree
  end

  it "should return an array of Gollum::Git::Blob objects for Tree#blobs" do
    @tree.blobs.should be_a Array
    @tree.blobs.each{|blob| blob.should be_a Gollum::Git::Blob}
  end
end