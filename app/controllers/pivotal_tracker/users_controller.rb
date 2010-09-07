require 'pivotal_tracker/token'

class PivotalTracker::UsersController < ApplicationController
  def login
    if !params[:pivotal_tracker].nil? and (token = PivotalTracker::Token.get_token(params[:pivotal_tracker][:login], params[:pivotal_tracker][:password]))
      projects = PivotalTracker::Project.all(token)
      render :partial => "pivotal_tracker/projects", :locals => { :projects => projects }, :layout => false
    else
      render :json => {
        :form => render_to_string(:partial => "pivotal_tracker/login"),
        :error_message => "could not get token"
      }, :status => 400, :layout => false
    end
  end
end