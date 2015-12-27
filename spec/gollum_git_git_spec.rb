require 'spec_helper'

describe Gollum::Git::Git do

  let(:repo) { Gollum::Git::Repo.new(fixture('dot_bare_git'), is_bare: true) }

  subject(:git) { repo.git }

  it "has an exist? method" do
    expect(git).to respond_to(:exist?)
  end

  it "has a push method" do
    (2..3).each{|i| expect(git).to respond_to(:push).with(i).arguments}
  end

  it "has a pull method" do
    (2..3).each{|i| expect(git).to respond_to(:pull).with(i).arguments}
  end
  
  it "has a grep method" do
    expect(git).to respond_to(:grep).with(2).arguments
  end

  it "has an rm method" do
    expect(git).to respond_to(:rm)
  end

  context "Gollum specific methods" do
    it "has a versions_for_path method" do
        expect(git).to respond_to(:versions_for_path).with(3).arguments
    end
  end

  context "porcelain API" do

    it "has a ls_files method" do
      expect(git).to respond_to(:ls_files).with(2).arguments
    end

    it "has a checkout method" do
      expect(git).to respond_to(:checkout).with(3).arguments
    end

    it "has an apply_path method" do
      (1..2).each{|i| expect(git).to respond_to(:apply_patch).with(i).arguments}
    end

    it "has a cat_file method" do
      expect(git).to respond_to(:cat_file).with(2).arguments
    end

  end

end
