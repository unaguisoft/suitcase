Rails.application.routes.draw do

  root 'main#home'

  post 'logout', to: 'user_sessions#destroy', as: :logout
  get 'login', to: 'user_sessions#new', as: :login
  
  resources :users
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:create, :edit, :update, :new]
end
