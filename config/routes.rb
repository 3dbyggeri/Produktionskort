Produktionskort::Application.routes.draw do
  devise_for :users

  root :to => 'work_processes#index'

  match 'om' => 'about#index', :as => 'about', :conditions => { :method => :get }

  resources :projects, :except => :show do
    collection do
      get :switch
      post :switch
    end
  end

  resources :work_processes
end
