require File.join(File.dirname(__FILE__) + '/../../spec_helper')
require 'github/repository'

describe Github::Repository do
  
  def create_client
    Octopussy::Client.new(:login => GITHUB_LOGIN, :password => GITHUB_PASSWORD)
  end
  
  it "should not find repositories without login" do
    repositories = Github::Repository.all(nil, GITHUB_PASSWORD)
    repositories.should be_empty
  end
  
  it "should not find repositories without password" do
    repositories = Github::Repository.all(GITHUB_LOGIN, nil)
    repositories.should be_empty
  end
  
  it "should not find repositories with wrong login" do
    lambda {
      Github::Repository.all(GITHUB_WRONG_LOGIN, GITHUB_WRONG_PASSWORD)
    }.should raise_error(Octopussy::NotFound)
  end
  
  it "should find repositories" do
    repositories = Github::Repository.all(GITHUB_LOGIN, GITHUB_PASSWORD)
    repositories.should_not be_empty
  end
  
  it "should find names in repositories" do
    Github::Repository.all(GITHUB_LOGIN, GITHUB_PASSWORD).each do |repository|
      repository.name.should_not be_empty
    end    
  end
  
  
  
  it "should not find collaborators without client" do
    collaborators = Github::Repository.new(nil, GITHUB_LOGIN, GITHUB_PASSWORD, GITHUB_REPOSITORY_NAME).collaborators
    collaborators.should be_empty
  end

  it "should not find collaborators without login" do    
    collaborators = Github::Repository.new(create_client, nil, GITHUB_PASSWORD, GITHUB_REPOSITORY_NAME).collaborators
    collaborators.should be_empty
  end

  it "should not find collaborators without password" do    
    collaborators = Github::Repository.new(create_client, GITHUB_LOGIN, nil, GITHUB_REPOSITORY_NAME).collaborators
    collaborators.should be_empty
  end

  it "should find collaborators" do
    collaborators = Github::Repository.new(create_client, GITHUB_LOGIN, GITHUB_PASSWORD, GITHUB_REPOSITORY_NAME).collaborators
    collaborators.should_not be_empty
  end

  it "should find collaborators and myself in the list" do
    collaborators = Github::Repository.new(create_client, GITHUB_LOGIN, GITHUB_PASSWORD, GITHUB_REPOSITORY_NAME).collaborators
    collaborators.select{|x| x.name == GITHUB_LOGIN}.first.name.should eql(GITHUB_LOGIN)
  end
    
end
