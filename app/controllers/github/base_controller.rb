class Github::BaseController < ApplicationController

  private
  
  def load_repositories(credentials)
    Github::Repository.all(credentials[:login], credentials[:password])
  end
  
  def load_repository
    if session[:github_credentials] and params[:repository_name]      
      @repository = (@repositories = load_repositories(session[:github_credentials])).select{|x| x.name == params[:repository_name]}.first
    end
  end
  
end