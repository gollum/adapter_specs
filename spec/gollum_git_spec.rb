require 'spec_helper'

describe Gollum::Git do
    it "returns the global default branch" do
        expect(Gollum::Git).to respond_to(:global_default_branch).with(0).arguments
        expect(Gollum::Git.global_default_branch.to_s).to eq `git config --global init.defaultBranch`.to_s.chomp
    end
end
