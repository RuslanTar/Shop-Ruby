Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #
  # Defines the root path route ("/")
  root 'products#index'

  resources :products do
    resources :order_items, only: %i[index show create update destroy]
  end

  resources :orders
end
