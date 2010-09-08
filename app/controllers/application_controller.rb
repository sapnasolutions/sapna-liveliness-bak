# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  class NoLoginFoundException         < Exception; end
  class NoTokenFoundException         < Exception; end
  class NoProjectsFoundException      < Exception; end
  class NoProjectFoundException       < Exception; end
  class NoMemberFoundException        < Exception; end  
  class NoDateIntervalFoundException  < Exception; end
  class StartBeforeEndException       < Exception; end
  class NoRepositoriesFoundException  < Exception; end
  class NoRepositoryFoundException    < Exception; end
  class NoCredentialsFoundException   < Exception; end
  
  def login
    session[:pivotal_tracker_token] = nil
  end
  
  private
  
  def render_json_error(form, message)
    render :json => {
      :form => form,
      :error_message => message
    }, :status => 400, :layout => false
  end
  
  
end
