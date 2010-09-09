class ReportsController < ApplicationController
  
  def generate
    
    
    
    
  end
  
  
  private
  
  def load_activities
    
    
  end
  
  def load_project
    raise NoTokenFoundException.new unless session[:pivotal_tracker_token]
    # Github::Project.
  end
  
end