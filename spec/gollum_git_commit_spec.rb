require 'spec_helper'

describe Gollum::Git::Commit do

  let(:repo) { Gollum::Git::Repo.new(fixture('dot_bare_git'), is_bare: true) }

  subject(:commit) { repo.commits.first }

  it "has an id, author, authored date, and a message" do
    expect(commit).to respond_to(:id)
    expect(commit).to respond_to(:author)
    expect(commit).to respond_to(:authored_date)
    expect(commit).to respond_to(:message)
  end

  it "returns a Gollum::Git::Actor object for author" do
    expect(commit.author).to be_a Gollum::Git::Actor
  end

  it "prints the id with to_s" do
    expect(commit.to_s).to eq commit.id
  end

  it "has stats" do
    expect(commit.stats.files).to include(["new.md", 1, 0, 1])
  end

  it "returns a single Gollum::Git::Tree object for Commit#tree" do
    expect(commit.tree).to be_a Gollum::Git::Tree
  end

end
