require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe PivotalTracker::MembersController, "selecting a date" do
  integrate_views
  
  it "should return error: token not found" do
    session[:pivotal_tracker_token] = nil
    post :dates, :project_id => "114774", :member_id => "367423"
    response.should_not be_success
    response.should include_text("no token found")
  end
  
  it "should return error: no project_id" do
    # TODO
  end

  it "should return error: wrong project_id" do
    session[:pivotal_tracker_token] = "8d2f5e20b85eb9ac46352a7fa67cc61f"
    post :dates, :project_id => "foo", :member_id => "367423"
    response.should_not be_success
    response.should include_text("no project found")
  end

  it "should return error: no member_id" do
    # TODO
  end
  
  it "should return error: wrong member_id" do
    session[:pivotal_tracker_token] = "8d2f5e20b85eb9ac46352a7fa67cc61f"
    post :dates, :project_id => "114774", :member_id => "foo"
    response.should_not be_success
    response.should include_text("no member found")
  end

  it "should return the date form" do
    session[:pivotal_tracker_token] = "8d2f5e20b85eb9ac46352a7fa67cc61f"
    post :dates, :project_id => "114774", :member_id => "367423"
    response.should be_success
    response.should render_template('shared/_dates.html.erb')
  end
  

end
