require 'spec_helper'

describe Gollum::Git::Blob do

  let(:repo) { Gollum::Git::Repo.new(fixture('dot_bare_git'), is_bare: true) }

  subject(:blob) { repo.commits[0].tree.blobs.first }

  it "has a create method that returns a Gollum::Git::Blob" do
    expect(Gollum::Git::Blob).to respond_to(:create).with(2).arguments
    test_blob = repo.head.commit.tree.blobs.first
    test_options = {id: test_blob.id, size: test_blob.size, mode: test_blob.mode, path: test_blob.name }
    expect(Gollum::Git::Blob.create(repo, test_options)).to be_a Gollum::Git::Blob
  end

  it "has a data method" do
    expect(blob).to respond_to(:data)
  end

  it "has a mime-type method" do
    expect(blob).to respond_to(:mime_type)
  end

  it "has a name" do
    expect(blob).to respond_to(:name)
  end

  it "has an id" do
    expect(blob).to respond_to(:id)
  end

  it "has a mode" do
    expect(blob).to respond_to(:mode)
  end

  it "has a size" do
    expect(blob).to respond_to(:size)
  end

  it "has an extension for symlinks" do
    expect(blob).to respond_to(:is_symlink)
    expect(blob).to respond_to(:symlink_target).with(1).argument
  end

end