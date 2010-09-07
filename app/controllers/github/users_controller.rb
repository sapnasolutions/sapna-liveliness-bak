require 'github/repository'

class Github::UsersController < ApplicationController
  def repositories
    if params[:github]
      repositories = Github::Repository.all(params[:github][:login], params[:github][:password])
      session[:github_login] = params[:github]
      render :partial => "github/repositories", :locals => { :repositories => repositories }, :layout => false
    else
      render :json => {
        :form => render_to_string(:partial => "github/login"),
        :error_message => "could not get repositories"
      }, :status => 400, :layout => false
    end
  end
end