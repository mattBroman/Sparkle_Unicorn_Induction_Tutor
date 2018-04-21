Rails.application.routes.draw do
  get '/login', to: 'sessions#new', as: 'ok'
  post '/login', to: 'sessions#create', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  resources :tags
  resources :sections
  resources :users
  get 'welcome/index', as: 'home'
  post 'welcome/index'
  
  resources :question do
    member do
      post 'grade'
    end
  end
  
  get 'admin/users', to: 'users#index', as: 'admin_users'
  get 'admin/sections', to: 'sections#admin_index', as: 'admin_sections'
  get 'admin/tags', to: 'tags#admin_index', as: 'admin_tags'
  get 'admin/questions', to: 'question#admin_index', as: 'admin_questions'
  get '/enroll', to: 'sections#enroll_index', as: 'view_enroll'
  post 'question/create', to: 'question#create', as: 'create_question'
  patch 'question/(:id)/update', to: 'question#update', as: 'update_question'
  get 'question/(:id)/destroy', to: 'question#destroy', as: 'delete_question'
  get 'users/(:id)/destroy', to: 'users#destroy', as: 'delete_user'
  get 'tags/(:id)/destroy', to: 'tags#destroy', as: 'delete_tag'
  get 'sections/(:id)/destroy', to: 'sections#destroy', as: 'delete_section'
  get 'sections/(:section_id)/enroll/(:user_id)', to: 'sections#enroll', as: 'enroll'
  get 'sections/(:section_id)/unenroll/(:user_id)', to: 'sections#unenroll', as: 'unenroll'
  get '404', to: 'welcome#fail', as: 'welcome_fail' 
  root 'welcome#index'
end

Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]
  
  root to: "home#show"
  
end