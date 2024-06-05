Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/users/:id", to: "users#show", as: :user

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

  resources :invites, only: %i[ create ]
  get "/notifications", to: "invites#index", as: :notifications
  patch "/invites/:id/accept", to: "invites#accept", as: :accept
  patch "/invites/:id/decline", to: "invites#decline", as: :decline
end
