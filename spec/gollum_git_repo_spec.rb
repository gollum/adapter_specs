require 'spec_helper'

describe Gollum::Git::Repo do

  subject(:repo) { Gollum::Git::Repo.new(fixture('dot_bare_git'), is_bare: true) }

  it "has a Gollum::Git::Repo::init_bare method" do
    expect(Gollum::Git::Repo).to respond_to(:init_bare)
  end

  it "has a path method" do
    expect(repo).to respond_to(:path)
  end

  it "returns a Gollum::Git::Git object for Repo#git" do
    expect(repo.git).to be_a Gollum::Git::Git
  end

  it "returns an array of Gollum::Git::Commit objects for Repo#commits" do
    expect(repo.commits).to be_a Array
    repo.commits.each{|commit| expect(commit).to be_a Gollum::Git::Commit}
  end

  it "returns a Gollum::Git::Ref object for Repo#head" do
    expect(repo.head).to be_a Gollum::Git::Ref
  end

  it "returns an array of Gollum::Git::Commit objects for log" do
    expect(repo).to respond_to(:log).with(3).arguments
    expect(repo.log.first).to be_a Gollum::Git::Commit
  end

  it "tracks pathnames for log" do
    expect(repo).to respond_to(:log).with(3).arguments
    result = repo.log('refs/heads/master', 'History.txt', {:follow => true}).first
    expect(result).to be_a Gollum::Git::Commit
    expect(result.tracked_pathname).to eq 'History.txt'
  end

  it "has a diff method" do
    (2..3).each{|i| expect(repo).to respond_to(:diff).with(i).arguments}
  end
  
  it "has a diff method" do
    (2..3).each{|i| expect(repo).to respond_to(:diff).with(i).arguments}
    patch = repo.diff(repo.commits[0].id, repo.commits[1].id)
    expect(patch.encoding.to_s).to eq 'UTF-8'
  end

  it "finds a branch from a list of branch names" do
    expect(repo).to respond_to(:find_branch).with(1).arguments
    expect(repo.find_branch(['master'])).to eq 'master'
    expect(repo.find_branch(['testing', 'master'])).to eq 'testing'
    expect(repo.find_branch(['foo'])).to be_nil
  end

  it "lists specific trees in the repo" do
    results = repo.lstree(repo.head.commit.id, 'lib', recursive: false)
    expect(results).to be_a Array
    expect(results.length).to eq 2
    expect((results.find {|x| x[:name] == 'grit.rb' })[:type]).to eq 'blob'
    expect((results.find {|x| x[:name] == 'grit' })[:type]).to eq 'tree'
  end

  it "lists specific trees in the repo recursively" do
    results = repo.lstree(repo.head.commit.id, 'lib', recursive: true)
    expect(results).to be_a Array
    expect(results.length).to eq 23
    expect((results.find {|x| x[:name] == 'grit.rb' })[:type]).to eq 'blob'
    expect((results.find {|x| x[:name] == 'grit' })[:type]).to eq 'tree'
    expect((results.find {|x| x[:name] == 'commit.rb' })[:type]).to eq 'blob'
  end

  it "lists the root tree in the repo recursively by default" do
    results = repo.lstree(repo.head.commit.id, '/')
    expect(results).to be_a Array
    expect(results.length).to eq 77
    expect((results.find {|x| x[:name] == 'img' })[:type]).to eq 'tree'
    expect((results.find {|x| x[:name] == 'Döner.md' })[:type]).to eq 'blob'
  end
end
