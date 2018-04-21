Rails.application.routes.draw do
  get 'sessions/create'

  get 'sessions/destroy'

  get 'home/show'

  get 'welcome/index'
  post 'welcome/index'
  
  resources :question do
    member do
      post 'grade'
    end
  end
  
  get 'question/(:id)/destroy', to: 'question#destroy', as: 'delete_question' 
  
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