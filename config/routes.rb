Rails.application.routes.draw do
  resources :posts do
    resources :comments, module: :posts
    member do
      put 'like', to: 'posts#like'
    end
  end

  get '/user/:id', to: 'user#show', as: 'user'
  get '/user/:id/likes', to: 'user#likes', as: 'user_likes'

  root 'home#index'

  devise_for :users, path: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
end
