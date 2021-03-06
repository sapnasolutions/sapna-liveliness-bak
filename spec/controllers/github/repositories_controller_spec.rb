require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe Github::RepositoriesController, "selecting a repository from github" do
  integrate_views
  
  it "should return error: credentials not found" do
    session[:github_credentials] = nil
    post :collaborators, :repository_name => GITHUB_REPOSITORY_NAME
    response.should_not be_success
    response.should include_text("no credentials found")
  end
  
  it "should return error: no repository_name" do
    session[:github_credentials] = { :login => GITHUB_LOGIN, :password => GITHUB_PASSWORD }
    post :collaborators, :repository_name => ""
    response.should_not be_success
    response.should include_text("no repository found")
  end

  it "should return error: wrong repository_name" do
    session[:github_credentials] = { :login => GITHUB_LOGIN, :password => GITHUB_PASSWORD }
    post :collaborators, :repository_name => "fakerepository"
    response.should_not be_success
    response.should include_text("no repository found")
  end

  it "should return the collabotrators of a selected repository" do
    session[:github_credentials] = { :login => GITHUB_LOGIN, :password => GITHUB_PASSWORD }
    post :collaborators, :repository_name => GITHUB_REPOSITORY_NAME
    response.should be_success
    response.should render_template('github/_collaborators.html.erb')
  end
  

end
