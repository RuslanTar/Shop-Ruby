Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #
  # Defines the root path route ("/")
  root 'products#index'

  resources :products do
    resources :order_items, only: %i[index show create update destroy]
  end

  resources :orders

  devise_scope :user do
    # Redirests signing out users back to sign-in
    get "users", to: "users/sessions#new"
  end

  devise_for :users, module: "users"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
