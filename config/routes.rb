Produktionskort::Application.routes.draw do
  devise_for :users

  root :to => 'projects#index'

  match 'om' => 'about#index', :as => 'about', :conditions => { :method => :get }

  resources :projects do
    collection do
      get :switch
      post :switch
    end

    resources :work_processes, :shallow => true

    namespace :byggeweb do
      resources :folders, :only => [:index, :show] do
        resources :files, :only => :index
      end
    end
    namespace :fileshare do
      resources :folders, :only => :index
      resources :files, :only => :index
    end
    namespace :bips do
      resources :sections, :only => [:index, :show] do
        resources :content, :only => :index
      end
    end
  end
end
