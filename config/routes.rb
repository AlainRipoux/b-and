Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "/users", to: "users#index", as: :users
  resources :bands
  get "/mybands", to: "bands#mybands", as: :mybands

  # resources :users do
  #   resources :invites do
  #     resources :messages, only: :create
  #   end
  #   resources :bands do
  #     resources :user_bands do
  #       resources :band_messages, only: :create
  #     end
  #   end
  # end
  # resources :bands, only: %i[new create]
  # resources :messages, only: :show
  # resources :band_messages, only: :show
  # resources :invites, only: %i[index]
  # resources :user_bands, only: %i[index]
  # resources :user_bands, only: %i[edit update destroy]
  # resources :invites, only: %i[edit update destroy]

end
