Rails.application.routes.draw do
  resources :posts do
    resources :comments, module: :posts
    member do
      put 'like', to: 'posts#like'
    end
  end

  resources :users, only: [:show] do
    member do
      get 'likes', to: 'users#likes'
      put 'follow', to: 'users#follow'
      get 'followers', to: 'users#followers'
    end
  end

  root 'feed#index'

  devise_for :users, path: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
end
