Rails.application.routes.draw do

  root "static_pages#home"
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :categories do
    resources :words do
      resources :answer
    end
  end
  resources :relationships,       only: [:create, :destroy]
end
