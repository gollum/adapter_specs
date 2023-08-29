require 'spec_helper'

describe Gollum::Git::Index do

  let(:bare_repo) { Gollum::Git::Repo.new(fixture('dot_bare_git'), is_bare: true) }
  subject(:index) { bare_repo.index }

  let(:repo) { Gollum::Git::Repo.new(cloned_testpath(fixture('dot_bare_git')), is_bare: false) }
  subject(:index_with_worktree) { repo.index }

  it "responds to add, delete and commit" do
    expect(index).to respond_to(:add).with(2).arguments
    expect(index).to respond_to(:delete).with(1).argument
    expect(index).to respond_to(:commit).with(1).argument
    expect(index).to respond_to(:commit).with(5).arguments
  end

  it "returns a hashmap for Index#tree" do
    expect(index.tree).to be_a Hash
  end

  it "has a read_tree method" do
    expect(index).to respond_to(:read_tree).with(1).argument
  end

  it "loads the current tree with Index#read_tree" do
    expect(index.current_tree).to be_nil
    index.read_tree(bare_repo.head.commit.id)
    expect(index.current_tree).to_not be_nil
  end

  it "returns a Gollum::Git::Tree for Index#current_tree" do
    index.read_tree(bare_repo.head.commit.id)
    expect(index.current_tree).to be_a Gollum::Git::Tree
  end

  it "determines whether a path in the workdir has new content for a non-bare repo" do
    path = 'History.txt'
    expect(index_with_worktree.workdir_path_modified?(path)).to be false

    filepath = File.join(repo.path, '../', path)
    f = File.open(filepath, 'w')
    f.puts "Workdir no longer clean"
    f.close
    
    expect(index_with_worktree.workdir_path_modified?('History.txt')).to be true

    File.delete(filepath)
    expect(index_with_worktree.workdir_path_modified?('History.txt')).to be false
  end

  it "returns false for #workdir_path_modified? if repo is bare" do
    expect(index.workdir_path_modified?('History.txt')).to be false
  end

end