Rails.application.routes.draw do
  devise_for :users
  root "static_pages#index"
  resources :product_carts, only: [:index, :create, :update, :destroy]
  resources :product_orders, only: :create
  resources :guests, only: :create
end
