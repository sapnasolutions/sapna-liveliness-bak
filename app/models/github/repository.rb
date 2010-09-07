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
    end
    
  end
end