Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Defines the root path route ("/")
  authenticated :user do
    root 'lists#index', :as => :authenticated_root
  end
  root 'pages#home'

  get '/lists' => 'lists#index', :as => :user_root

  resources :lists do
    resources :items, only: [:create]
    resources :invitations, only: [:create]
  end

  resources :items, only: [:update, :destroy]

  resources :invitations, only: [:destroy] do
    member do
      post "accept", to: "invitations#accept"
    end
  end

  resources :user_lists, only: [:destroy]
end
