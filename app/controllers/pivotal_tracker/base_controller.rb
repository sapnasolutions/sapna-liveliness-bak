require 'pivotal_tracker/project'

class PivotalTracker::BaseController < ApplicationController

  class NoLoginFoundException     < Exception; end
  class NoTokenFoundException     < Exception; end
  class NoProjectsFoundException  < Exception; end
  class NoProjectFoundException   < Exception; end
  class NoMemberFoundException    < Exception; end
  
  private
  
  def load_project
    if session[:pivotal_tracker_token] and params[:project_id]
      @projects = PivotalTracker::Project.all(session[:pivotal_tracker_token]) 
      @project = @projects.select{|x| x.id == params[:project_id]}.first
    end
  end
  
  def load_member
    if @project and params[:member_id]
      @member = @project.memberships.select{|x| x.id == params[:member_id]}.first
    end
  end
  
  def render_json_error(form, message)
    render :json => {
      :form => form,
      :error_message => message
    }, :status => 400, :layout => false
  end

end