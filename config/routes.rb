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
  
  post 'question/create', to: 'question#create', as: 'create_question'
  patch 'question/(:id)/update', to: 'question#update', as: 'update_question'
  get 'question/(:id)/destroy', to: 'question#destroy', as: 'delete_question'
  get 'users/(:id)/destroy', to: 'users#destroy', as: 'delete_user'
  get 'tags/(:id)/destroy', to: 'tags#destroy', as: 'delete_tag'
  get 'sections/(:id)/destroy', to: 'sections#destroy', as: 'delete_section'
  get 'sections/(:section_id)/enroll/(:user_id)', to: 'sections#enroll', as: 'enroll'
  get 'sections/(:section_id)/unenroll/(:user_id)', to: 'sections#unenroll', as: 'unenroll'
  root 'welcome#index'
end
