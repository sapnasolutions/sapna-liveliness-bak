# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def indicator(options = {})
    options = {:size => :small}.merge(options)
    content_tag :span, :class => "indicator #{options[:class]}", :style => "display: none" do
      image_tag("indicators/#{options[:size]}.gif") 
    end
  end
  
end
