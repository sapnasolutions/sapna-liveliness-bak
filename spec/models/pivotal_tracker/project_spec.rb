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
  
  it "should not find single project without token" do
    lambda {
      PivotalTracker::Project.find_for_id(nil, PIVOTAL_TRACKER_PROJECT_ID)
    }.should raise_error(PivotalTracker::NoTokenException)
  end
  
  it "should find single project with token" do
    project = PivotalTracker::Project.find_for_id(PIVOTAL_TRACKER_TOKEN, PIVOTAL_TRACKER_PROJECT_ID)
    project.should_not be_nil
  end
  
end
