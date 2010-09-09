require File.join(File.dirname(__FILE__) + '/../../spec_helper')
require 'pivotal_tracker/project'

describe PivotalTracker::Project do
  
  it "should not find projects without token" do
    lambda {
      PivotalTracker::Project.all(nil)
    }.should raise_error(PivotalTracker::NoTokenException)
  end

  it "should find all projects with token" do
    projects = PivotalTracker::Project.all(
      PivotalTracker::Token.get_token(PIVOTAL_TRACKER_LOGIN, PIVOTAL_TRACKER_PASSWORD)
    )
    projects.should_not eql([])
    projects.size.should >= 1
  end
  
  it "should find memerships for project" do
    projects = PivotalTracker::Project.all(
      PivotalTracker::Token.get_token(PIVOTAL_TRACKER_LOGIN, PIVOTAL_TRACKER_PASSWORD)
    )
    memberships = projects.first.memberships
    projects.should_not eql([])
    projects.size.should >= 1
  end
  
end
