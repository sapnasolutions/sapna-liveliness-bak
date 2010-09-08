class Github::RepositoriesController < Github::BaseController
  
  before_filter :load_repository
  
  def list
    raise NoCredentialsFoundException.new   unless session[:github_credentials]
    
    session[:github_repository_name] = nil
    session[:github_collaborator_name] = nil
    
    render :partial => "github/repositories", :locals => { :repositories => load_repositories(session[:github_credentials]) }, :layout => false
  rescue NoCredentialsFoundException
    render_json_error("please login again", "no credentials found")
  end

  def collaborators
    raise NoCredentialsFoundException.new   unless session[:github_credentials]
    raise NoRepositoryFoundException.new    unless params[:repository_name]
    raise NoRepositoriesFoundException.new  unless @repositories
    raise NoRepositoryFoundException.new    unless @repository
    
    session[:github_repository_name] = @repository.name
    session[:github_collaborator_name] = nil
    
    render :partial => '/github/collaborators', :locals => { :repository => @repository, :collaborators => load_collaborators(@repository) }
  rescue NoCredentialsFoundException
    render_json_error("please login again", "no credentials found")
  rescue NoRepositoriesFoundException
    render_json_error("please login again", "no repositories found")
  rescue NoRepositoryFoundException
    render_json_error(render_to_string(:partial => "/github/repositories", :locals => { :repositories => @repositories }), "no repository found")
  end
  
end