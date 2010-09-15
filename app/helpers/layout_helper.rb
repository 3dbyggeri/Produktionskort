# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title)
    @content_for_title = page_title.to_s
  end

  def quicklinks(links)
    @content_for_quicklinks = links.map do |link|
      name, path = link
      content_tag :li, link_to(name, path)
    end.join

    unless links.empty?
      @content_for_quicklinks = content_tag :ul, @content_for_quicklinks, :id => 'quicklinks'
    end
  end

  def sidebar(links, sidebar_options = {})
    @content_for_sidebar = links.map do |link|
      name, path, options = link
      options ||= {}
      options[:class] = current_page?(path) ? [options[:class], 'active'].compact.join(' ') : options[:class]
      content_tag :li, link_to(name, path, options)
    end.join

    unless links.empty?
      @content_for_sidebar = content_tag :ul, @content_for_sidebar, :class => 'sideNav'
    end

    if sidebar_options.include?(:submit)
      @content_for_sidebar += content_tag :button, sidebar_options[:submit][0], :id => 'form_submitter', :rel => sidebar_options[:submit][1]
    end
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end
  
  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
end
