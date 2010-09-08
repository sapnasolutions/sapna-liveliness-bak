require 'pivotal_tracker/token'

class PivotalTracker::UsersController < PivotalTracker::BaseController

  def login
    raise NoLoginFoundException.new unless params[:pivotal_tracker]
    raise NoTokenFoundException.new unless (token = get_token(params[:pivotal_tracker]))
    session[:pivotal_tracker_token] = token
    render :partial => "pivotal_tracker/projects", :locals => { :projects => load_projects(token) }, :layout => false
  rescue NoLoginFoundException
    render_json_error("please login again", "no login information found")
  rescue NoTokenFoundException
    render_json_error("please login again", "no token found")
  end
  
  private
  
  def get_token(params)
    PivotalTracker::Token.get_token(params[:login], params[:password])
  end
  
end