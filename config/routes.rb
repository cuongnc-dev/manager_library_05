Rails.application.routes.draw do

  mount Ckeditor::Engine => "/ckeditor"
  root "static_pages#homepage"
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  post "admin/login", to: "sessions#create_admin"
  delete "logout", to: "sessions#destroy"
  delete "admin/logout", to: "sessions#destroy_admin"

  resources :users
  resources :account_activations, only: [:new, :create, :edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  namespace :admin do
    root "books#index"
    get "login", to: "admin#new"
    get "search", to: "admin#index"
    resources :books
    resources :authors
    resources :publishers
    resources :categories
    resources :requests
    resources :users
  end
end
