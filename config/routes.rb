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

  namespace :user do
    get 'roles/index'

    resources :roles
  end

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server_error'
  get 'dashboard/index'
  get 'truckloads/index'
  get 'ctes/index'
  get 'clients/index'
  get 'drivers/index'
  get 'agents/index'
  get 'transfer_requests/index'

  devise_for :users
  resources :truckloads
  resources :ctes
  resources :clients
  resources :drivers
  resources :agents
  resources :transfer_requests do
    collection do
      get :truckload_information
      get :pending
      patch :cancel
    end
  end
  root to: 'dashboard#index'
end
