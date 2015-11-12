require 'spec_helper'

describe Gollum::Git::Blob do

  let(:repo) { Gollum::Git::Repo.new(fixture('dot_bare_git'), :is_bare => true) }

  subject(:blob) { repo.commits[0].tree.blobs.first }

  it "should have a create method that returns a Gollum::Git::Blob" do
    expect(Gollum::Git::Blob).to respond_to(:create).with(2).arguments
    test_blob = repo.head.commit.tree.blobs.first
    test_options = {:id => test_blob.id, :size => test_blob.size, :mode => test_blob.mode, :path => test_blob.name }
    expect(Gollum::Git::Blob.create(repo, test_options)).to be_a Gollum::Git::Blob
  end

  it "should have a data method" do
    expect(blob).to respond_to(:data)
  end

  it "should have a mime-type method" do
    expect(blob).to respond_to(:mime_type)
  end

  it "should have a name" do
    expect(blob).to respond_to(:name)
  end

  it "should have an id" do
    expect(blob).to respond_to(:id)
  end

  it "should have a mode" do
    expect(blob).to respond_to(:mode)
  end

  it "should have a size" do
    expect(blob).to respond_to(:size)
  end

  it "should have an extension for symlinks" do
    expect(blob).to respond_to(:is_symlink)
    expect(blob).to respond_to(:symlink_target).with(1).argument
  end

end