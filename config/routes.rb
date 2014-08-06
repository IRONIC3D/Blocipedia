Rails.application.routes.draw do

  resources :charges, only: [:new, :create]

  devise_for :users

  resources :wikis

  root to: 'welcome#index'
  
end
