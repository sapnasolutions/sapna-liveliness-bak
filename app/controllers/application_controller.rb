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
  class NoCollaboratorFoundException  < Exception; end
  
  def login
    # session[:pivotal_tracker_token]       = nil
    # session[:pivotal_tracker_project_id]  = nil
    # session[:pivotal_tracker_member_id]   = nil
    # session[:github_credentials]          = nil
    # session[:github_repository_name]      = nil
    # session[:github_collaborator_name]    = nil
    respond_to do |format|
      format.js do 
        render :update do |page|
          page.replace_html("")
        end
      end
      format.html
    end
  end
  
  private
  
  def render_json_error(form, message)
    render :json => {
      :form => form,
      :error_message => message
    }, :status => 400, :layout => false
  end
  
  def has_all_pivotal_tracker_info?
    return !session[:pivotal_tracker_token].nil? && !session[:pivotal_tracker_project_id].nil? && !session[:pivotal_tracker_member_id].nil?
  end
  
  def has_all_github_info?
    return !session[:github_credentials].nil?    && !session[:github_repository_name].nil?       && !session[:github_collaborator_name].nil?
  end
  
end
