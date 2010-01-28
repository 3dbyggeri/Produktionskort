ActionController::Routing::Routes.draw do |map|
  map.root :controller => "page"
  map.resources :projects
  map.resources :work_processes
end
