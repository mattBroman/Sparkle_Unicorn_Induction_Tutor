Rails.application.routes.draw do
  get 'welcome/index'
  post 'welcome/index'
  
  get 'induction/index'
  post 'induction/index'
  
  root 'welcome#index'
end
