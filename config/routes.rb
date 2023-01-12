Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#home'

  # get '/dashboard' => 'user_lists#index', :as => :user_root
  get '/lists' => 'lists#index', :as => :user_root

  resources :lists do
    resources :items, only: [:create]
    resources :invitations, only: [:create]
    # resources :user_lists, only: [:create] # is this route being used?
  end

  resources :items, only: [:update, :destroy]

  resources :invitations, only: [:destroy] do
    member do
      post "accept", to: "invitations#accept"
    end
  end

  resources :user_lists, only: [:destroy]
end
