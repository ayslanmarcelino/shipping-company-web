# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :super_admins do
    get 'enterprises/index'
    get 'users/index'

    resources :enterprises
    resources :users
  end

  namespace :admins do
    get 'users/index'
    get 'enterprises/index'
    get 'clients/index'

    resources :users
    resources :enterprises
    resources :clients
  end

  get 'dashboard/index'
  get 'truckloads/index'

  devise_for :users
  resources :truckloads
  root to: 'dashboard#index'
end
