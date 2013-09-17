require 'spec_helper'

describe Gollum::Git::Actor do
  before(:each) do
    @repo = Gollum::Git::Repo.new(fixture('dot_bare_git'), :is_bare => true)
    @actor = Gollum::Git::Actor.new("Tom Werner", "tom@example.com")
  end

  it "should have accessors for name and email" do
    @actor.should respond_to(:name)
    @actor.should respond_to(:email)
  end

  it "should have an output method" do
    @actor.should respond_to(:output)
  end

end