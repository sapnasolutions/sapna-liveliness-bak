require 'pivotal_tracker/project'

class PivotalTracker::ProjectsController < ApplicationController

  class NoTokenFoundException < Exception; end
  class NoProjectFoundException < Exception; end

  def members
    raise NoTokenFoundException.new("no token found") unless session[:pivotal_tracker_token]
    raise NoProjectFoundException.new("project not found") unless (project = get_selected_project(session[:pivotal_tracker_token], params))
    memberships = project.memberships
    render :partial => '/pivotal_tracker/members', :locals => { :project => project, :memberships => memberships }
  rescue NoTokenFoundException => e
    render :json => {
      :form => "please login again",
      :error_message => e.message
    }, :status => 400, :layout => false
  rescue NoProjectFoundException => e
    render :json => {
      :form => render_to_string(:partial => "/pivotal_tracker/projects", :locals => { :projects => @projects }),
      :error_message => e.message
    }, :status => 400, :layout => false
  end
  
private
  def get_selected_project(token, params)
    @projects = PivotalTracker::Project.all(session[:pivotal_tracker_token])
    return params[:project_id] ? @projects.select{|x| x.id == params[:project_id] }.first : nil
  end

end