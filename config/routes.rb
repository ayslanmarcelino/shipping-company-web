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
      post :approve
      post :reject
    end
  end
  root to: 'dashboard#index'
end
