Rails.application.routes.draw do
  resources :posts
  resources :user, only: [:show]
  
  root 'home#index'

  devise_for :users, path: 'auth'
end
