Rails.application.routes.draw do
  resources :posts do
    resources :comments, module: :posts
    resources :likes
  end

  resources :user, only: [:show]

  root 'home#index'

  devise_for :users, path: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
end
