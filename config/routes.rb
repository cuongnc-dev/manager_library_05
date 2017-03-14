Rails.application.routes.draw do
  root "static_pages#homepage"
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users
  resources :account_activations, only: [:new, :create, :edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
