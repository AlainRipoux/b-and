Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "/users/:id", to: "users#show", as: :user

  resources :invites, only: %i[ create ] do
    resources :messages, only: :create, as: :messages
    get :messages, to: "messages#show"
  end
  # get "/invites", to: "invites#create", as: :create_invites

  resources :bands, except: [:index]

  get "/messages", to: "messages#index", as: :messages

  get "/users/:id/edit", to: "users#edit", as: :edit_user
  patch "/users/:id", to: "users#update"
  get "/mybands", to: "bands#mybands", as: :mybands
  resources :bands do
    resources :tasks, only: [:new, :create, :edit, :update, :destroy]
    resources :band_messages, only: :create
  end

  resources :user_bands, only: :show
end
