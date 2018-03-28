Rails.application.routes.draw do
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
