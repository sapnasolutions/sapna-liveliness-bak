class Github::CollaboratorsController < Github::BaseController

  before_filter :load_repository
  before_filter :load_collaborator

  def dates
    raise NoCredentialsFoundException.new   unless session[:github_credentials]
    raise NoRepositoryFoundException.new    unless params[:repository_name]
    raise NoCollaboratorFoundException.new  unless params[:collaborator_name]
    raise NoRepositoriesFoundException.new  unless @repositories
    raise NoRepositoryFoundException.new    unless @repository
    raise NoCollaboratorFoundException.new  unless @collaborator
    
    session[:github_repository_name]    = @repository.name
    session[:github_collaborator_name]  = @collaborator.name
    
    if has_all_pivotal_tracker_info? && has_all_github_info?
      render :partial => "/shared/dates", :locals => { 
        :path => github_report_path(@repository, @collaborator), 
        :repository => @repository, 
        :collaborator => @collaborator
      }
    else
      render :partial => "/github/wait_for", :locals => { :repository => @repository, :collaborator => @collaborator }
    end
  rescue NoCredentialsFoundException
    render_json_error("please login again", "no credentials found")
  rescue NoRepositoriesFoundException
    render_json_error("please login again", "no repositories found")
  rescue NoRepositoryFoundException
    render_json_error(render_to_string(:partial => "/github/repositories", :locals => { :repositories => @repositories }), "no repository found")
  rescue NoCollaboratorFoundException
    render_json_error(render_to_string(:partial => "/github/repositories", :locals => { :repositories => @repositories }), "no collaborator found")
  end
  

end