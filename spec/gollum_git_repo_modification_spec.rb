require 'spec_helper'
require 'rspec/expectations'
require 'tmpdir'

RSpec::Matchers.define :a_blob_named do |expected|
  match do |actual|
    actual.is_a?(Gollum::Git::Blob) && actual.name == expected
  end
end

def testrepo
  tmp = Dir.mktmpdir
  FileUtils.cp_r(File.join(fixture('dot_bare_git'), '.'), tmp)
  tmp
end

describe Gollum::Git::Repo do

  before(:all) do
    @tmp = testrepo
  end

  after(:all) do
    FileUtils.remove_entry(@tmp)
  end

  after(:each) do
    if parent_commit != repo.head.commit
      repo.update_ref(repo.head.name, parent_commit.id)
    end
  end

  let(:repo) { Gollum::Git::Repo.new(@tmp, is_bare: true) }

  let(:index) do
    repo.index.read_tree(repo.head.commit.tree.id)
    repo.index
  end

  let(:actor) { Gollum::Git::Actor.new("Tom Werner", "tom@example.com") }

  let(:message) { 'Test commit' }

  let(:parent_commit) { repo.head.commit }

  def commit_index
    index.commit(message, [parent_commit], actor, nil, repo.head.name)
  end

  describe "#head#commit" do

    context "after committing" do

      before(:each) do
        index.add('Add.txt', 'Some data')
        commit_index
      end

      subject(:commit) { repo.head.commit }

      it "has the expected message" do
        expect(commit.message).to eq message
      end

      it "has the expected author" do
        expect(commit.author.name).to eq actor.name
        expect(commit.author.email).to eq actor.email
      end

      it "has a recent authored_date" do
        expect(commit.authored_date).to be < Time.now
        expect(commit.authored_date).to be > Time.now - 1
      end

      it "has the expected id" do
        # That also checks parent, committer and committed_date
        # A change in any of these will cause an id mismatch
        date = commit.authored_date
        expected_content =
          "tree #{commit.tree.id}\n" +
          "parent #{parent_commit.id}\n" +
          "author #{actor.output(date)}\n" +
          "committer #{actor.output(date)}\n" +
          "\n" +
          "#{message}"
        expected_commit =
          "commit #{expected_content.bytesize}\0#{expected_content}"
        expected_sha = Digest::SHA1.hexdigest(expected_commit)

        expect(commit.id).to eq expected_sha
      end

    end

  end

  describe "#head#commit#tree" do

    subject(:tree) { repo.head.commit.tree }

    context "initially" do
      it "does not have a blob named 'Add.txt'" do
        expect(tree.blobs).to_not include( a_blob_named('Add.txt') )
      end

      it "has a blob named 'History.txt'" do
        expect(tree.blobs).to include( a_blob_named('History.txt') )
      end

    end

    context "after adding a new file" do

      let(:filename) { 'Add.txt' }

      let(:data) { 'Some data' }

      before(:each) do
        index.add(filename, data)
        commit_index
      end

      it "has a blob with the name of the added file" do
        expect(tree.blobs).to include( a_blob_named(filename) )
      end

      it "has a blob of that name with the expected data" do
        blob = tree.blobs.select { |blob| blob.name == filename }.first
        expect(blob.data).to eq data
      end

    end

    context "after modifying file 'History.txt'" do

      let(:filename) { 'History.txt' }

      let(:data) { 'Some data' }

      before(:each) do
        index.add(filename, data)
        commit_index
      end

      it "has a blob named with the name of the modified file" do
        expect(tree.blobs).to include( a_blob_named(filename) )
      end

      it "has a blob of that name with the expected data" do
        blob = tree.blobs.select { |blob| blob.name == filename }.first
        expect(blob.data).to eq data
      end
    end

    context "after deleting a file", skip: true do

      let(:filename) { 'History.txt' }

      before(:each) do
        index.delete(filename)
        commit_index
      end

      it "does not have a blob with that name anymore" do
        expect(tree.blobs).to_not include( a_blob_named(filename) )
      end

    end

  end

end