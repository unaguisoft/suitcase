Rails.application.routes.draw do

  root 'main#home'

  post 'logout', to: 'user_sessions#destroy', as: :logout
  get 'login', to: 'user_sessions#new', as: :login
  
  resources :users
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:create, :edit, :update, :new]
  
  resources :categories, except: [:show] do
    get 'upload_category_photos', to: 'categories#upload_category_photos', on: :member
    match 'photos', via: [:post, :patch], to: 'photos#create'
  end

  resources :photos, only: [:destroy]
  
end
