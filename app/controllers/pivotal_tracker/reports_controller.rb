class PivotalTracker::ReportsController < PivotalTracker::BaseController

  before_filter :load_project
  before_filter :load_member

  def generate  
    raise NoTokenFoundException.new         unless session[:pivotal_tracker_token]
    raise NoProjectsFoundException.new      unless @projects
    raise NoProjectFoundException.new       unless @project
    raise NoProjectFoundException.new       unless params[:project_id]
    raise NoMemberFoundException.new        unless params[:member_id]
    raise NoMemberFoundException.new        unless @member
    raise NoDateIntervalFoundException.new  unless params[:date_interval]
    
    start_date = Date.parse(params[:date_interval][:start_date])
    end_date = Date.parse(params[:date_interval][:end_date])
    raise StartBeforeEndException.new       if start_date > end_date
    
    render :text => "FOO"
    #render :partial => "/shared/dates", :locals => { :path => pivotal_tracker_report_path(@project, @member) }
  rescue NoTokenFoundException
    render_json_error("please login again", "no token found")
  rescue NoProjectsFoundException
    render_json_error("please login again", "no projects found")
  rescue NoProjectFoundException
    render_json_error(render_to_string(:partial => "/pivotal_tracker/projects", :locals => { :projects => @projects }), "no project found")
  rescue NoMemberFoundException
    render_json_error(render_to_string(:partial => "/pivotal_tracker/projects", :locals => { :projects => @projects }), "no member found")
  rescue NoDateIntervalFoundException
    render_json_error(render_to_string(:partial => "/pivotal_tracker/projects", :locals => { :projects => @projects }), "no date interval found")
  rescue StartBeforeEndException
    render_json_error(render_to_string(:partial => "/pivotal_tracker/projects", :locals => { :projects => @projects }), "start date is before end date")
  end
  

end