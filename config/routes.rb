Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#home'

  get '/dashboard' => 'user_lists#index', :as => :user_root

  resources :lists, except: [:index] do
    resources :items, only: [:create]
  end

  resources :items, only: [:update, :destroy]
end
