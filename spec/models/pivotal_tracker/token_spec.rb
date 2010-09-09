require File.join(File.dirname(__FILE__) + '/../../spec_helper')
require 'pivotal_tracker/token'

describe PivotalTracker::Token do
  
  it "should not find token: wrong login" do
    PivotalTracker::Token.get_token('foo', 'bar').should be_nil
  end

  it "should not find token: wrong password" do
    PivotalTracker::Token.get_token(PIVOTAL_TRACKER_LOGIN, 'bar').should be_nil    
  end

  it "should find token" do
    token = PivotalTracker::Token.get_token(PIVOTAL_TRACKER_LOGIN, PIVOTAL_TRACKER_PASSWORD)
    token.should_not be_nil
    token.should eql(PIVOTAL_TRACKER_TOKEN)
  end
    
end
