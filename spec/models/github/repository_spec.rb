require File.join(File.dirname(__FILE__) + '/../../spec_helper')
require 'github/repository'

describe Github::Repository do
  
  it "should not find repositories without login" do
    repositories = Github::Repository.all(nil, "foo")
    repositories.should be_empty
  end
  
  it "should not find repositories without password" do
    repositories = Github::Repository.all("foo", nil)
    repositories.should be_empty
  end
  
  it "should not find repositories with wrong login" do
    repositories = Github::Repository.all("riencroonenborghs1", "bar")
    repositories.should be_empty
  end
  
  it "should find repositories" do
    repositories = Github::Repository.all("riencroonenborghs", "r13ncr00n3nb0rghs")
    repositories.should_not be_empty
  end
    
end
