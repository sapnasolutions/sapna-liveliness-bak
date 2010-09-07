require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe PivotalTracker::ProjectsController, "selecting a project from pivotal tracker" do
  integrate_views
  
  it "should return error: token not found" do
    session[:pivotal_tracker_token] = nil
    post :members, :project_id => "114774"
    response.should_not be_success
    response.should include_text("no token found")
  end
  
  it "should return error: no project_id" do
    # TODO
  end

  it "should return error: wrong project_id" do
    session[:pivotal_tracker_token] = "8d2f5e20b85eb9ac46352a7fa67cc61f"
    post :members, :project_id => "foo"
    response.should_not be_success
    response.should include_text("no project found")
  end

  it "should return the members of a selected project" do
    session[:pivotal_tracker_token] = "8d2f5e20b85eb9ac46352a7fa67cc61f"
    post :members, :project_id => "114774"
    response.should be_success
    response.should render_template('pivotal_tracker/_members.html.erb')
  end
  

end
