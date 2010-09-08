require File.join(File.dirname(__FILE__) + '/../../spec_helper')
require 'github/repository'

describe Github::Repository do
  
  LOGIN = "riencroonenborghs"
  PASSWORD = "r13ncr00n3nb0rghs"  
  WRONG_LOGIN = "somemadeupusernamethatdoesnotexist"
  WRONG_PASSWORD = "foo"
  REPOSITORY_NAME = "foo-bar-1"
  
  def create_client
    Octopussy::Client.new(:login => LOGIN, :password => PASSWORD)
  end
  
  it "should not find repositories without login" do
    repositories = Github::Repository.all(nil, PASSWORD)
    repositories.should be_empty
  end
  
  it "should not find repositories without password" do
    repositories = Github::Repository.all(LOGIN, nil)
    repositories.should be_empty
  end
  
  it "should not find repositories with wrong login" do
    lambda {
      Github::Repository.all(WRONG_LOGIN, WRONG_PASSWORD)
    }.should raise_error(Octopussy::NotFound)
  end
  
  it "should find repositories" do
    repositories = Github::Repository.all(LOGIN, PASSWORD)
    repositories.should_not be_empty
  end
  
  it "should find names in repositories" do
    Github::Repository.all(LOGIN, PASSWORD).each do |repository|
      repository.name.should_not be_empty
    end    
  end
  
  
  
  it "should not find collaborators without client" do
    collaborators = Github::Repository.new(nil, LOGIN, PASSWORD, REPOSITORY_NAME).collaborators
    collaborators.should be_empty
  end

  it "should not find collaborators without login" do    
    collaborators = Github::Repository.new(create_client, nil, PASSWORD, REPOSITORY_NAME).collaborators
    collaborators.should be_empty
  end

  it "should not find collaborators without password" do    
    collaborators = Github::Repository.new(create_client, LOGIN, nil, REPOSITORY_NAME).collaborators
    collaborators.should be_empty
  end

  it "should find collaborators" do
    collaborators = Github::Repository.new(create_client, LOGIN, PASSWORD, REPOSITORY_NAME).collaborators
    collaborators.should_not be_empty
  end

  it "should find collaborators and myself in the list" do
    collaborators = Github::Repository.new(create_client, LOGIN, PASSWORD, REPOSITORY_NAME).collaborators
    collaborators.select{|x| x.name == LOGIN}.first.name.should eql(LOGIN)
  end
    
end
