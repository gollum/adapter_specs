require 'spec_helper'

describe Gollum::Git::Tree do

  let(:repo) { Gollum::Git::Repo.new(fixture('dot_bare_git'), is_bare: true) }

  subject(:tree) { repo.head.commit.tree }

  it "returns an array of Gollum::Git::Blob objects for Tree#blobs" do
    expect(tree.blobs).to be_a Array
    tree.blobs.each{|blob| expect(blob).to be_a Gollum::Git::Blob}
  end

end