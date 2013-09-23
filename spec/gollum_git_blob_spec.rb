require 'spec_helper'

describe Gollum::Git::Blob do
  before(:each) do
    @repo = Gollum::Git::Repo.new(fixture('dot_bare_git'), :is_bare => true)
    @blob = @repo.commits[0].tree.blobs.first
  end

  it "should have a create method that returns a Gollum::Git::Blob" do
    Gollum::Git::Blob.should respond_to(:create).with(2).arguments
    test_blob = @repo.head.commit.tree.blobs.first
    test_options = {:id => test_blob.id, :size => test_blob.size, :mode => test_blob.mode, :path => test_blob.name }
    Gollum::Git::Blob.create(@repo, test_options).should be_a Gollum::Git::Blob
  end
  
  it "should have a data method" do
    @blob.should respond_to(:data)
  end
  
  it "should have a mime-type method" do
    @blob.should respond_to(:mime_type)
  end
  
  it "should have a name" do
    @blob.should respond_to(:name)
  end
  
  it "should have an id" do
    @blob.should respond_to(:id)
  end
  
  it "should have a mode" do
    @blob.should respond_to(:mode)
  end
  
  it "should have a size" do
    @blob.should respond_to(:size)
  end

  it "should have an extension for symlinks" do
    @blob.should respond_to(:is_symlink)
    @blob.should respond_to(:symlink_target).with(1).argument
  end
end