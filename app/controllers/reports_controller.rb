class ReportsController < ApplicationController
  
  
  def generate
    report = Report.new(params, session)
    report.generate

  rescue Report::NoDateIntervalFoundException
    render_json_error(render_to_string(:partial => "/shared/dates"), "no date interval found")
  rescue Report::StartBeforeEndDateException
    render_json_error(render_to_string(:partial => "/shared/dates"), "start date is after end date")
  rescue Report::DateIntervalInFutureException
    render_json_error(render_to_string(:partial => "/shared/dates"), "date is in the future")
  rescue Report::NoTokenFoundException
    render_json_error(render_to_string(:partial => "/shared/dates"), "pivotal tracker: no token found")
  rescue Report::NoProjectFoundException
    render_json_error(render_to_string(:partial => "/shared/dates"), "pivotal tracker: no project found")
  end
  
  
  private
  
  
end