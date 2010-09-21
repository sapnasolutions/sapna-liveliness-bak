class PivotalTracker::ProjectsController < PivotalTracker::BaseController
  
  before_filter :load_project

  def list
    raise NoTokenFoundException.new unless (token = session[:pivotal_tracker_token])
    
    session[:pivotal_tracker_project_id] = nil
    session[:pivotal_tracker_member_id] = nil
    @projects = load_projects(token)
    render :update do |page|
      page.replace_html("pivotal-content", render(:partial => "pivotal_tracker/projects"))
    end
    #render :partial => "pivotal_tracker/projects", :locals => { :projects => load_projects(token) }, :layout => false
  rescue NoTokenFoundException
    render_json_error("please login again", "no token found")
  end
  
  def members
    raise NoTokenFoundException.new     unless session[:pivotal_tracker_token]
    raise NoProjectFoundException.new   unless params[:project_id]
    raise NoProjectsFoundException.new  unless @projects
    raise NoProjectFoundException.new   unless @project
    
    session[:pivotal_tracker_project_id] = @project.id
    session[:pivotal_tracker_member_id] = nil
    @members = @project.memberships
    render :update do |page|
      page.replace_html("pivotal-content", render(:partial => "/pivotal_tracker/members"))
    end
    #render :partial => '/pivotal_tracker/members', :locals => { :project => @project, :members => @project.memberships }
  rescue NoTokenFoundException
    render_json_error("please login again", "no token found")
  rescue NoProjectsFoundException
    render_json_error("please login again", "no projects found")
  rescue NoProjectFoundException
    render_json_error(render_to_string(:partial => "/pivotal_tracker/projects", :locals => { :projects => @projects }), "no project found")
  end
  
end