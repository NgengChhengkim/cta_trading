Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "registrations"}
  root "static_pages#index"

  resources :product_carts, only: [:index, :create, :update, :destroy]
  resources :product_orders, only: [:new, :create]
  resources :guests, only: :create
end
