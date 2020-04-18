require 'spec_helper'

describe Gollum::Git::Actor do

  subject(:actor) { Gollum::Git::Actor.new("Tom Werner", "tom@example.com") }

  it "has accessors for name, email and time" do
    expect(actor).to respond_to(:name)
    expect(actor).to respond_to(:email)
    expect(actor).to respond_to(:time)
  end

  it "has an output method" do
    expect(actor).to respond_to(:output)
  end

end
