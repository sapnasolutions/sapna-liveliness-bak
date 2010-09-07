require File.join(File.dirname(__FILE__) + '/../../spec_helper')
require 'pivotal_tracker/token'

describe PivotalTracker::Token do
  
  it "should not find token: wrong login" do
    PivotalTracker::Token.get_token('foo', 'bar').should be_nil
  end

  it "should not find token: wrong password" do
    PivotalTracker::Token.get_token('rien@sapnasolutions.com', 'bar').should be_nil    
  end

  it "should find token" do
    token = PivotalTracker::Token.get_token('rien@sapnasolutions.com', 's4pn4s0lut10ns')
    token.should_not be_nil
    token.should eql("8d2f5e20b85eb9ac46352a7fa67cc61f")
  end
    
end
