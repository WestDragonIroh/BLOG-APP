Rails.application.routes.draw do
  root 'home#index'
  resources :users
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy'
  # resources :sessions, only: [:create]
end
