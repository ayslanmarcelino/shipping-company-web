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

    resources :users
    resources :enterprises
  end

  get 'dashboard/index'
  get 'providers/index'
  get 'product_categories/index'

  devise_for :users
  resources :providers
  resources :product_categories
  root to: 'dashboard#index'
end
