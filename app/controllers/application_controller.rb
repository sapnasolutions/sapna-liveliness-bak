# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  
  def login
    session[:pivotal_tracker_token] = nil
  #   session[:pivotal_tracker_project_id] = nil
  #   session[:pivotal_tracker_member_id] = nil
  end
  
end
