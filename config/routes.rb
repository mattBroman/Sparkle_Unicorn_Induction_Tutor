Rails.application.routes.draw do
  get 'welcome/index'
  post 'welcome/index'
  
  resources :question do
    member do
      post 'grade'
    end
  end
  
  root 'welcome#index'
end
