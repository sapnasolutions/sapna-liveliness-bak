require 'pivotal_tracker/project'

class Report
  
  class NoDateIntervalFoundException  < Exception; end
  class StartBeforeEndDateException   < Exception; end
  class DateIntervalInFutureException < Exception; end
  class NoTokenFoundException         < Exception; end
  class NoProjectFoundException       < Exception; end
  class NoDateFoundException          < Exception; end
  class NoStartDateFoundException     < Exception; end
  class NoEndDateFoundException       < Exception; end
  class NoMemberFoundException        < Exception; end
  class NoSessionHashFoundException   < Exception; end
  class NoParamsHashFoundException    < Exception; end
    
  attr_reader :params, :session
  
  def initialize(params, session)
    raise NoParamsHashFoundException.new unless params
    raise NoSessionHashFoundException.new unless session
    @params = params
    @session = session
  end
  
  def generate
    (start_date, end_date) = check_date_interval
    project = get_project
    member = get_member(project)
    activities = get_activities(start_date, end_date, project)
    filtered_activities = filter_activities(activities, member)
  end
  
  private
  
  def check_date_interval
    raise NoDateIntervalFoundException.new  unless @params[:date_interval]
    start_date  = DateTime.parse(@params[:date_interval][:start_date])
    end_date    = DateTime.parse(@params[:date_interval][:end_date])    
    raise StartBeforeEndDateException.new   if start_date > end_date
    raise DateIntervalInFutureException.new if start_date > Time.now
    return [start_date, end_date]
  end
  
  def get_project
    raise NoTokenFoundException.new unless @session[:pivotal_tracker_token]
    raise NoProjectFoundException.new unless @session[:pivotal_tracker_project_id]
    project = PivotalTracker::Project.find_for_id(@session[:pivotal_tracker_token], @session[:pivotal_tracker_project_id])
    raise NoProjectFoundException.new unless project
    return project
  end
  
  def get_member(project)
    raise NoProjectFoundException.new unless project
    raise NoMemberFoundException.new unless @session[:pivotal_tracker_member_id]
    member = project.memberships.select{|x| x.id == @session[:pivotal_tracker_member_id]}.first
    raise NoMemberFoundException.new unless member
    return member
  end
  
  def get_activity_for(project, date)
    raise NoProjectFoundException.new unless project
    raise NoDateFoundException.new unless date
    project.activities(date)
  end

  def get_activities(start_date, end_date, project)
    raise NoStartDateFoundException.new unless start_date
    raise NoEndDateFoundException.new unless end_date
    activities = []
    start_date.to_date.upto(end_date.to_date) do |date| 
      activities << get_activity_for(project, date)
      activities.flatten!
      activities.uniq!
    end
    return activities
  end
  
  def filter_activities(list, member)
    return list.select{|x| x.author = member.name}
  end
  
  
end