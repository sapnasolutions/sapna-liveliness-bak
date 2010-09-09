require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe Github::CollaboratorsController, "selecting a date" do
  integrate_views
  
  
  it "should return error: credentials not found" do
    session[:github_credentials] = nil
    post :dates, :repository_name => GITHUB_REPOSITORY_NAME, :collaborator_name => GITHUB_COLLABORATOR_NAME
    response.should_not be_success
    response.should include_text("no credentials found")
  end
  
  it "should return error: no repository_name" do
    # TODO
  end

  it "should return error: wrong repository_name" do
    session[:github_credentials] = { :login => GITHUB_LOGIN, :password => GITHUB_PASSWORD }
    post :dates, :repository_name => "foo", :collaborator_name => GITHUB_COLLABORATOR_NAME
    response.should_not be_success
    response.should include_text("no repository found")
  end

  it "should return error: no collaborator_name" do
    # TODO
  end
  
  it "should return error: wrong collaborator_name" do
    session[:github_credentials] = { :login => GITHUB_LOGIN, :password => GITHUB_PASSWORD }
    post :dates, :repository_name => GITHUB_REPOSITORY_NAME, :collaborator_name => "foo"
    response.should_not be_success
    response.should include_text("no collaborator found")
  end

  it "should return the date form" do
    session[:github_credentials] = { :login => GITHUB_LOGIN, :password => GITHUB_PASSWORD }
    session[:pivotal_tracker_token] = "foo"
    session[:pivotal_tracker_project_id] = "foo"
    session[:pivotal_tracker_member_id] = "foo"
    post :dates, :repository_name => GITHUB_REPOSITORY_NAME, :collaborator_name => GITHUB_COLLABORATOR_NAME
    response.should be_success
    response.should render_template('shared/_dates.html.erb')
  end

  it "should return the wait_for form" do
    session[:github_credentials] = { :login => GITHUB_LOGIN, :password => GITHUB_PASSWORD }
    post :dates, :repository_name => GITHUB_REPOSITORY_NAME, :collaborator_name => GITHUB_COLLABORATOR_NAME
    response.should be_success
    response.should render_template('github/_wait_for.html.erb')
  end
  

end
