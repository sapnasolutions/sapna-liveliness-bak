require File.join(File.dirname(__FILE__) + '/../../spec_helper')

describe PivotalTracker::UsersController, "logging into pivotal tracker" do
  integrate_views
  
  it "should return error when login failed: wrong params hash" do
    post :login, :foo => { :login => "foo", :password => "bar" }
    response.should_not be_success
    response.should include_text("could not get token")
  end

  it "should return error when login failed: wrong login" do
    post :login, :pivotal_tracker => { :login => "foo", :password => "bar" }
    response.should_not be_success
    response.should include_text("could not get token")
  end

  it "should return projects when login successful" do
    post :login, :pivotal_tracker => { :login => "rien@sapnasolutions.com", :password => "s4pn4s0lut10ns" }
    response.should be_success
    response.should render_template('pivotal_tracker/_projects.html.erb')
  end

end
