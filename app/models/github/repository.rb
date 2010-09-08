require 'octopussy'

module Github
  class Repository
    
    def self.all(login, password)
      return [] if login.nil? or password.nil?
      client = Octopussy::Client.new(:login => login, :password => password)
      return [] unless client
      return client.list_repos
    rescue Octopussy::NotFound
      return []
    rescue Octopussy::Unauthorized
      return []
    end
    
    def collaborators(login, password, repository_name)
      return [] if login.nil? or password.nil? or repository_name.nil?
      client = Octopussy::Client.new(:login => login, :password => password)
      return [] unless client
      return client.collaborators(repository_name)
    rescue Octopussy::Unauthorized
      return []
    end
    
  end
end