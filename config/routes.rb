# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  # ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #
  # Defines the root path route ("/")
  root 'products#index'

  namespace :admin do
    get '/', to: 'home#index'
    get 'dashboard', to: 'home#dashboard', as: :dashboard
    resources :products do
      collection do
        get 'search'
        get 'filter'
      end
    end
    resources :users do
      collection do
        get 'search'
        get 'filter'
      end
    end
  end

  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  else
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      username == 'admin' && password == ENV['SIDEKIQ_PASSWORD']
    end
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :products do
    collection do
      get 'search'
      get 'filter'
    end

    resources :order_items, only: %i[index create update destroy]
  end

  resources :orders do
    collection do
      post 'cancel_order', as: :cancel
    end
  end

  devise_scope :user do
    # Redirests signing out users back to sign-in
    get 'users', to: 'users/sessions#new'
  end

  # get 'locale', to: 'translations#switch_locale', as: :switch_locale

  scope :devise do
    devise_for :users, module: 'users'
  end

  resources :users do
    collection do
      get 'search'
      get 'filter'
    end
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
