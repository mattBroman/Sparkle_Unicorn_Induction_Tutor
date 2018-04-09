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
  
  get 'question/(:id)/destroy', to: 'question#destroy', as: 'delete_question' 
  
  root 'welcome#index'
end
