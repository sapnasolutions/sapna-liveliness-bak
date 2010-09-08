require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe Github::UsersController, "logging into github" do
  integrate_views
  
  it "should return error when login failed: wrong params hash" do
    post :login, :foo => { :login => "foo", :password => "bar" }
    response.should_not be_success
    response.should include_text("no login information found")
  end

  it "should return error with unexisting/wrong user" do
    post :login, :github => { :login => "someuserthatdoesntexist", :password => "bar" }
    response.should_not be_success
    response.should include_text("no repositories found")
  end

  it "should return repositories with correct user (public repositories only)" do
    post :login, :github => { :login => "riencroonenborghs", :password => "r13ncr00n3nb0rghs" }
    response.should be_success
    response.should render_template('github/_repositories.html.erb')
  end

end
