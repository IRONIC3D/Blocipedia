Rails.application.routes.draw do

  resources :wikis

  root to: 'welcome#index'
  
end
