Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, path: 'auth'
end
