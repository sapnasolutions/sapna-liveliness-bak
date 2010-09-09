require File.join(File.dirname(__FILE__) + '/../spec_helper')
require 'report'

describe Report do

  it "init: should raise NoParamsHashFoundException" do
    lambda {
      Report.new(nil, {})
    }.should raise_error(Report::NoParamsHashFoundException)
  end
  it "init: should raise NoSessionHashFoundException" do
    lambda {
      Report.new({}, nil)
    }.should raise_error(Report::NoSessionHashFoundException)
  end
  it "init: should init a report model" do
    lambda {
      Report.new({}, {})
    }.should_not raise_error(Report::NoParamsHashFoundException)
    lambda {
      Report.new({}, {})
    }.should_not raise_error(Report::NoSessionHashFoundException)
  end
  
  
  it "check_date_interval: should raise NoDateIntervalFoundException" do
    lambda {
      Report.new({}, {}).generate
    }.should raise_error(Report::NoDateIntervalFoundException)
  end  
  it "check_date_interval: should raise StartBeforeEndDateException" do
    lambda {
      report = Report.new({:date_interval => {:start_date => "2010/09/09", :end_date => "2010/08/08"}}, {})
      report.generate
    }.should raise_error(Report::StartBeforeEndDateException)
  end
  it "check_date_interval: should raise DateIntervalInFutureException" do
    lambda {
      report = Report.new({:date_interval => {:start_date => (Time.now+10.days).strftime("%Y/%m/%d"), 
                                              :end_date => (Time.now+11.days).strftime("%Y/%m/%d")}}, {})
      report.generate
    }.should raise_error(Report::DateIntervalInFutureException)
  end
  it "check_date_interval: should check date interval correctly" do
    lambda {
      report = Report.new({:date_interval => {:start_date => "2010/08/08", :end_date => "2010/08/10"}}, {})
      report.generate
    }.should_not raise_error(Report::StartBeforeEndDateException)
    lambda {
      report = Report.new({:date_interval => {:start_date => "2010/08/08", :end_date => "2010/08/10"}}, {})
      report.generate
    }.should_not raise_error(Report::DateIntervalInFutureException)
  end
  
  
  it "get project: should raise NoTokenFoundException" do
    lambda {
      report = Report.new({:date_interval => {:start_date => "2010/08/08", :end_date => "2010/08/10"}}, {})
      report.generate
    }.should raise_error(Report::NoTokenFoundException)  
  end
  it "get project: should raise NoProjectFoundException" do
    lambda {
      report = Report.new({:date_interval => {:start_date => "2010/08/08", :end_date => "2010/08/10"}}, 
                          {:pivotal_tracker_token => PIVOTAL_TRACKER_TOKEN})
      report.generate
    }.should raise_error(Report::NoProjectFoundException)  

    lambda {
      report = Report.new({:date_interval => {:start_date => "2010/08/08", :end_date => "2010/08/10"}}, 
                          {:pivotal_tracker_token => PIVOTAL_TRACKER_TOKEN, :pivotal_tracker_project_id => "foo"})
      report.generate
    }.should raise_error(Report::NoProjectFoundException)  
  end
  it "get project: should get project" do
    lambda {
      report = Report.new({:date_interval => {:start_date => "2010/08/08", :end_date => "2010/08/10"}}, 
                          {:pivotal_tracker_token => PIVOTAL_TRACKER_TOKEN, :pivotal_tracker_project_id => PIVOTAL_TRACKER_PROJECT_ID})
      report.generate
    }.should_not raise_error(Report::NoTokenFoundException)  
    lambda {
      report = Report.new({:date_interval => {:start_date => "2010/08/08", :end_date => "2010/08/10"}}, 
                          {:pivotal_tracker_token => PIVOTAL_TRACKER_TOKEN, :pivotal_tracker_project_id => PIVOTAL_TRACKER_PROJECT_ID})
      report.generate
    }.should_not raise_error(Report::NoProjectFoundException)  
  end
  
  
  it "get member: should raise NoMemberFoundException" do
    lambda {
      report = Report.new({:date_interval => {:start_date => "2010/08/08", :end_date => "2010/08/10"}}, 
                          {:pivotal_tracker_token => PIVOTAL_TRACKER_TOKEN, :pivotal_tracker_project_id => PIVOTAL_TRACKER_PROJECT_ID})
      report.generate
    }.should raise_error(Report::NoMemberFoundException)

    lambda {
      report = Report.new({:date_interval => {:start_date => "2010/08/08", :end_date => "2010/08/10"}}, 
                          { :pivotal_tracker_token => PIVOTAL_TRACKER_TOKEN, 
                            :pivotal_tracker_project_id => PIVOTAL_TRACKER_PROJECT_ID, 
                            :pivotal_tracker_member_id => "foo"})
      report.generate
    }.should raise_error(Report::NoMemberFoundException)
  end    
  it "get member: should get member" do
    lambda {
      report = Report.new({:date_interval => {:start_date => "2010/08/08", :end_date => "2010/08/10"}}, 
                          { :pivotal_tracker_token => PIVOTAL_TRACKER_TOKEN, 
                            :pivotal_tracker_project_id => PIVOTAL_TRACKER_PROJECT_ID, 
                            :pivotal_tracker_member_id => PIVOTAL_TRACKER_MEMBER_ID})
      report.generate
    }.should_not raise_error(Report::NoMemberFoundException)
  end
  
  it "get activities: should get filtered activities" do
    report = Report.new({:date_interval => {:start_date => "2010/08/08", :end_date => "2010/08/10"}}, 
                        { :pivotal_tracker_token => PIVOTAL_TRACKER_TOKEN, 
                          :pivotal_tracker_project_id => PIVOTAL_TRACKER_PROJECT_ID, 
                          :pivotal_tracker_member_id => PIVOTAL_TRACKER_MEMBER_ID})
    activities = report.generate
    activities.should_not be_nil
    activities.should_not be_empty
  end
    
end
