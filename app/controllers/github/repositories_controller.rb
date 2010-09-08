class Github::RepositoriesController < Github::BaseController
  
  before_filter :load_repository

  def collaborators
    raise NoCredentialsFoundException.new   unless session[:github_credentials]
    raise NoRepositoriesFoundException.new  unless @repositories
    raise NoRepositoryFoundException.new    unless @repository
    raise NoRepositoryFoundException.new    unless params[:repository_name]
    render :partial => '/github/collaborators', :locals => { :repository => @repository, :collaborators => @repository.collaborators }
  rescue NoCredentialsFoundException
    render_json_error("please login again", "no credentials found")
  rescue NoRepositoriesFoundException
    render_json_error("please login again", "no repositories found")
  rescue NoRepositoryFoundException
    render_json_error(render_to_string(:partial => "/github/repositories", :locals => { :repositories => @repositories }), "no repository found")
  end
  
end