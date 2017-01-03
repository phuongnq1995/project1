Rails.application.routes.draw do

  root "static_pages#home"
  get "signup" => "users#new"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :words
  resources :relationships,       only: [:create, :destroy]

  resources :categories do
    resources :lessons
  end
end
