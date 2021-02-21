Rails.application.routes.draw do
  resources :posts do
    resources :comments, module: :posts
    member do
      put 'like', to: 'posts#like'
    end
  end

  resources :user, only: [:show] do
    member do
      get 'likes', to: 'user#likes'
      put 'follow', to: 'user#follow'
    end
  end

  root 'home#index'

  devise_for :users, path: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
end
