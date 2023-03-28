require 'spec_helper'

describe Gollum::Git::Tree do

  let(:repo) { Gollum::Git::Repo.new(fixture('dot_bare_git'), is_bare: true) }

  subject(:tree) { repo.head.commit.tree }

  it "finds a blob by name" do
    result = tree.find_blob {|name| name == 'Döner.md'}
    expect(result).to be_a Gollum::Git::Blob
    expect(result.mode).to eq 0100644
    result = tree.find_blob {|name| name == 'Noexist.foo'}
    expect(result).to be_nil
    expect(tree.find_blob).to be_nil
  end

  it "returns an array of Gollum::Git::Blob objects for Tree#blobs" do
    expect(tree.blobs).to be_a Array
    tree.blobs.each do |blob|
      expect(blob).to be_a Gollum::Git::Blob
      expect(blob.mode).to eq 0100644
    end
  end

end