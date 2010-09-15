ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'work_processes'
  map.about 'om', :controller => 'about', :action => 'index', :conditions => { :method => :get }
  map.resources :projects, :collection => { :switch => [:post, :get] }, :except => :show
  map.resources :work_processes
end
