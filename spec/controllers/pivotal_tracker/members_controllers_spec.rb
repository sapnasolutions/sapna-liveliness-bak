require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe PivotalTracker::MembersController, "selecting a date" do
  integrate_views
  
  
  it "should return error: token not found" do
    session[:pivotal_tracker_token] = nil
    post :dates, :project_id => PIVOTAL_TRACKER_PROJECT_ID, :member_id => PIVOTAL_TRACKER_MEMBER_ID
    response.should_not be_success
    response.should include_text("no token found")
  end
  
  it "should return error: no project_id" do
    # TODO
  end

  it "should return error: wrong project_id" do
    session[:pivotal_tracker_token] = PIVOTAL_TRACKER_TOKEN
    post :dates, :project_id => "foo", :member_id => PIVOTAL_TRACKER_MEMBER_ID
    response.should_not be_success
    response.should include_text("no project found")
  end

  it "should return error: no member_id" do
    # TODO
  end
  
  it "should return error: wrong member_id" do
    session[:pivotal_tracker_token] = PIVOTAL_TRACKER_TOKEN
    post :dates, :project_id => PIVOTAL_TRACKER_PROJECT_ID, :member_id => "foo"
    response.should_not be_success
    response.should include_text("no member found")
  end

  it "should return the date form" do
    session[:pivotal_tracker_token] = PIVOTAL_TRACKER_TOKEN
    session[:github_credetials] = "foo"
    session[:github_repository_name] = "foo"
    session[:github_collaborator_name] = "foo"
    post :dates, :project_id => PIVOTAL_TRACKER_PROJECT_ID, :member_id => PIVOTAL_TRACKER_MEMBER_ID
    response.should be_success
    response.should render_template('shared/_dates.html.erb')
  end

  it "should return the wait_for form" do
    session[:pivotal_tracker_token] = PIVOTAL_TRACKER_TOKEN
    post :dates, :project_id => PIVOTAL_TRACKER_PROJECT_ID, :member_id => PIVOTAL_TRACKER_MEMBER_ID
    response.should be_success
    response.should render_template('pivotal_tracker/_wait_for.html.erb')
  end
  

end
