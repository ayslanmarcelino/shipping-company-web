# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :super_admins do
    get 'enterprises/index'

    resources :enterprises
  end
  
  namespace :admins do
    get 'users/index'
    get 'enterprises/index'
    
    resources :users
    resources :enterprises
  end
  
  get 'dashboard/index'
  get 'truckloads/index'
  get 'ctes/index'
  get 'clients/index'
  
  devise_for :users
  resources :truckloads
  resources :ctes
  resources :clients
  root to: 'dashboard#index'
end
