# frozen_string_literal: true

Rails.application.routes.draw do
  get '/', to: 'items#index', as: 'welcome'

  resources :items, except: %i[new create] do
    resources :reviews, only: %i[new create]
  end

  resources :merchants do
    resources :items, only: %i[new create index]
  end

  resources :reviews, only: %i[edit update destroy]

  resources :orders, only: %i[new create show]

  post '/cart/:item_id', to: 'cart#add_item'
  get '/cart', to: 'cart#show'
  delete '/cart', to: 'cart#empty'
  delete '/cart/:item_id', to: 'cart#remove_item'
  patch '/cart/:item_id/:increment_decrement', to: 'cart#increment_decrement'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/profile', to: 'users#show'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create', as: 'login_create'
  get '/logout', to: 'sessions#logout'

  namespace :admin do
    get '/', to: 'dashboard#index'
    get '/users', to: 'users#index'
  end

  namespace :merchant do
    get '/', to: 'dashboard#index', as: 'dashboard'
  end
end
