require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "registrations"}
  root "static_pages#index"

  resources :product_carts, only: [:index, :create, :update, :destroy]
  resources :product_invoices, only: [:new, :create, :destroy]
  resources :guests, only: :create
  resources :categories, only: :show
  resources :products, only: :show
  resources :invoices do
    resources :product_invoices, only: :index
  end

  mount Sidekiq::Web, at: "/sidekiq"
end
