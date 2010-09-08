class PivotalTracker::ProjectsController < PivotalTracker::BaseController
  
  before_filter :load_project

  def list
    raise NoTokenFoundException.new unless (token = session[:pivotal_tracker_token])
    render :partial => "pivotal_tracker/projects", :locals => { :projects => load_projects(token) }, :layout => false
  rescue NoTokenFoundException
    render_json_error("please login again", "no token found")
  end
  
  def members
    raise NoTokenFoundException.new     unless session[:pivotal_tracker_token]
    raise NoProjectFoundException.new   unless params[:project_id]
    raise NoProjectsFoundException.new  unless @projects
    raise NoProjectFoundException.new   unless @project
    render :partial => '/pivotal_tracker/members', :locals => { :project => @project, :members => @project.memberships }
  rescue NoTokenFoundException
    render_json_error("please login again", "no token found")
  rescue NoProjectsFoundException
    render_json_error("please login again", "no projects found")
  rescue NoProjectFoundException
    render_json_error(render_to_string(:partial => "/pivotal_tracker/projects", :locals => { :projects => @projects }), "no project found")
  end
  
end