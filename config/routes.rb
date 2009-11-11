ActionController::Routing::Routes.draw do |map|
  map.root :controller => "work_processes"
  map.resources :work_processes
  map.resources :projects
end
