module WaitForHelper

  def pivotal_tracker_wait_for_wrapper(&block)
    wait_for_wrapper({:type => "Github", :parent => :projects, :children => :members}, &block)
  end

  def github_wait_for_wrapper(&block)
    wait_for_wrapper({:type => "Pivotal Tracker", :parent => :repositories, :children => :collaborators}, &block)
  end
  
  private
  
  def wait_for_wrapper(options = {}, &block)
    options = {:navigation => capture(&block)}.merge(options)
    concat(render(:partial => "/shared/wait_for", :locals => options), block.binding)
  end

end