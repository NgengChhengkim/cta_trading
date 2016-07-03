require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "registrations"}
  root "static_pages#index"

  resources :product_carts, only: [:index, :create, :update, :destroy]
  resources :product_invoices, only: [:new, :create]
  resources :guests, only: :create
  resources :categories, only: :show

  mount Sidekiq::Web, at: "/sidekiq"
end
