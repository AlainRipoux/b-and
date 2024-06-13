Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :user_bands, only: :show

  get "/mybands", to: "bands#mybands", as: :mybands
  resources :bands do
    resources :tasks, only: [:new, :create]
    resources :events, only: [:new, :create]
    resources :band_messages, only: :create
    resources :documents, only: [:new, :create]
  end

  # Routes for users
  get "/users", to: "users#index", as: :users
  get "/users/:id", to: "users#show", as: :user
  get "/users/:id/edit", to: "users#edit", as: :edit_user
  patch "/users/:id", to: "users#update"

  # Routes for tasks
  resources :tasks, only: %i[destroy edit update]
  get "/tasks/:id", to: "tasks#change_task_status", as: :change_status

  # Routes for events
  resources :events, only: %i[index show edit update]
  # get "/events/:id", to: "events#change_task_status", as: :change_status

  # Routes for messages
  get "/messages", to: "messages#index", as: :messages

  # Routes for notifications / invites
  resources :invites, only: %i[ create ] do
    resources :messages, only: :create
    get :messages, to: "messages#show", as: :invite_messages
  end

  get "/notifications", to: "invites#index", as: :notifications
  patch "/invites/:id/accept", to: "invites#accept", as: :accept
  patch "/invites/:id/decline", to: "invites#decline", as: :decline
end
