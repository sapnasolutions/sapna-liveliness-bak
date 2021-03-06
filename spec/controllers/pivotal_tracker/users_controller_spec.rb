require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe PivotalTracker::UsersController, "logging into pivotal tracker" do
  integrate_views
  
  it "should return error when login failed: wrong params hash" do
    post :login, :foo => { :login => "foo", :password => "bar" }
    response.should_not be_success
    response.should include_text("no login information found")
  end

  it "should return error when login failed: wrong login" do
    post :login, :pivotal_tracker => { :login => "foo", :password => "bar" }
    response.should_not be_success
    response.should include_text("no token found")
  end

  it "should return error when login failed: wrong password" do
    post :login, :pivotal_tracker => { :login => PIVOTAL_TRACKER_LOGIN, :password => "thatissowronglike" }
    response.should_not be_success
    response.should include_text("no token found")
  end

  it "should return projects when login successful" do
    post :login, :pivotal_tracker => { :login => PIVOTAL_TRACKER_LOGIN, :password => PIVOTAL_TRACKER_PASSWORD }
    response.should be_success
    response.should render_template('pivotal_tracker/_projects.html.erb')
  end

end
