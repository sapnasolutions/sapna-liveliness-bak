class PivotalTracker::MembersController < PivotalTracker::BaseController

  before_filter :load_project
  before_filter :load_member

  def dates
    raise NoTokenFoundException.new     unless session[:pivotal_tracker_token]
    raise NoProjectFoundException.new   unless params[:project_id]
    raise NoMemberFoundException.new    unless params[:member_id]
    raise NoProjectsFoundException.new  unless @projects
    raise NoProjectFoundException.new   unless @project
    raise NoMemberFoundException.new    unless @member
    
    session[:pivotal_tracker_project_id] = @project.id
    session[:pivotal_tracker_member_id] = @member.id
    
    if has_all_pivotal_tracker_info? && has_all_github_info?
      render :partial => "/shared/dates"
    else
      render :partial => "/pivotal_tracker/wait_for", :locals => { :project => @project, :member => @member }, :status => 400
    end
  rescue NoTokenFoundException
    render_json_error("please login again", "no token found")
  rescue NoProjectsFoundException
    render_json_error("please login again", "no projects found")
  rescue NoProjectFoundException
    render_json_error(render_to_string(:partial => "/pivotal_tracker/projects", :locals => { :projects => @projects }), "no project found")
  rescue NoMemberFoundException
    render_json_error(render_to_string(:partial => "/pivotal_tracker/projects", :locals => { :projects => @projects }), "no member found")
  end
  

end