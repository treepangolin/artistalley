Rails.application.routes.draw do
  resources :posts do
    resources :comments, module: :posts
    member do
      put 'like', to: 'posts#like'
    end
  end

  resources :users, path: 'user', only: [:show] do
    member do
      get 'likes', to: 'users#likes'
      put 'follow', to: 'users#follow'
      get 'followers', to: 'users#followers'
    end
  end

  authenticated do
    root 'feed#index', as: :user_root
    resources :invites, only: %i[index new create]
    resources :messages
    resources :conversations, only: %i[index show] do
      collection do
        get 'sent'
      end
    end
  end

  unauthenticated do
    root 'welcome#index', as: :welcome_root
  end

  devise_for :users, path: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
end
