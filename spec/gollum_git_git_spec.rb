require 'spec_helper'

describe Gollum::Git::Git do
  before(:each) do
    @repo = Gollum::Git::Repo.new(fixture('dot_bare_git'), :is_bare => true)
    @git = @repo.git
  end

  it "should have an exist? method" do
    @git.should respond_to(:exist?)
  end
  
  it "should have a grep method" do
    @git.should respond_to(:grep)
  end

  it "should have an rm method" do
    @git.should respond_to(:rm)
  end  

  context "porcelain API" do
    it "should have a rev_list method" do
      @git.should respond_to(:rev_list).with(2).arguments
    end

    it "should have the ls_files method" do
      @git.should respond_to(:ls_files).with(2).arguments
    end
  
    it "should have a checkout method" do
      @git.should respond_to(:checkout).with(3).arguments
    end
  
    it "should have an apply_path method" do
      (1..3).each{|i| @git.should respond_to(:apply_patch).with(i).arguments}
    end
  
    it "should have a cat_file method" do
      @git.should respond_to(:cat_file).with(2).arguments
    end
  
    it "should have a refs method" do
      @git.should respond_to(:refs).with(2).arguments
    end

    it "should have a log method" do
      @git.should respond_to(:log).with(1).arguments
    end

  end

end