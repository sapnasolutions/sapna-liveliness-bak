require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe Github::UsersController, "logging into github" do
  integrate_views
  
  it "should return error when login failed: wrong params hash" do
    post :repositories, :foo => { :login => "foo", :password => "bar" }
    response.should_not be_success
    response.should include_text("could not get repositories")
  end

  it "should return error when login failed: wrong login" do
    post :repositories, :github => { :login => "foo", :password => "bar" }
    response.should_not be_success
    response.should include_text("could not get repositories")
  end

  it "should return projects when login successful" do
    post :repositories, :github => { :login => "riencroonenborghs", :password => "r13ncr00nenb0rghs" }
    response.should be_success
    response.should render_template('github/_repositories.html.erb')
  end

end
