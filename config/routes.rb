Produktionskort::Application.routes.draw do
  devise_for :users

  root :to => 'work_processes#index'

  match 'om' => 'about#index', :as => 'about', :conditions => { :method => :get }

  resources :projects, :except => :show do
    collection do
      get :switch
      post :switch
    end
    namespace :byggeweb do
      resources :folders, :only => [:index, :show] do
        resources :files, :only => :index
      end
    end
  end

  resources :work_processes
end
