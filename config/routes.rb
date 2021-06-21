# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :super_admins do
    get 'enterprises/index'

    resources :enterprises
  end

  namespace :admins do
    get 'enterprises/index'

    resources :enterprises
  end

  namespace :user do
    get 'roles/index'

    resources :roles
  end

  get 'dashboard/index'
  get 'truckloads/index'
  get 'ctes/index'
  get 'clients/index'
  get 'users/index'
  
  devise_for :users
  resources :truckloads
  resources :ctes
  resources :clients
  resources :users
  root to: 'dashboard#index'
end
