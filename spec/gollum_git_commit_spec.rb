require 'spec_helper'

def get_last_commit(commit)
  commit.parent ? get_last_commit(commit.parent) : commit
end

describe Gollum::Git::Commit do

  let(:repo) { Gollum::Git::Repo.new(fixture('dot_bare_git'), is_bare: true) }

  subject(:commit) { repo.commits.first }

  it "has an id, author, authored date, message, and parent" do
    expect(commit).to respond_to(:id)
    expect(commit).to respond_to(:author)
    expect(commit).to respond_to(:authored_date)
    expect(commit).to respond_to(:message)
    expect(commit).to respond_to(:parent)
  end

  it "returns a Gollum::Git::Actor object for author" do
    expect(commit.author).to be_a Gollum::Git::Actor
  end

  it "prints the id with to_s" do
    expect(commit.to_s).to eq commit.id
  end

  it "has stats" do
    stats = commit.stats.files[0] # This commit contains a rename
    expect(stats[:old_file]).to eq 'old.txt'
    stats = repo.commits[2].stats.files[0] # New file
    expect(stats[:new_additions]).to eq 1
    expect(stats[:new_deletions]).to eq 0
    expect(stats[:changes]).to eq 1
    expect(stats[:new_file]).to eq 'new.md'
    expect(stats[:old_file]).to eq nil
    stats = repo.commits[7].stats.files[0] # Normal file update
    expect(stats[:old_file]).to eq nil
  end

  it "returns a single Gollum::Git::Tree object for Commit#tree" do
    expect(commit.tree).to be_a Gollum::Git::Tree
  end

  it "returns a Gollum::Git::Commit object or nil for parent" do
    expect(commit.parent).to be_a Gollum::Git::Commit
    last_commit = get_last_commit(commit)
    expect(last_commit.parent).to eq nil
  end
end
