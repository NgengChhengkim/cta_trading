require "sidekiq/web"

Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "registrations"}
  root "static_pages#index"

  resources :product_carts, only: [:index, :create, :update, :destroy]
  resources :product_invoices, only: [:new, :create, :destroy]
  resources :guests, only: :create
  resources :categories, only: :show
  resources :products, only: :show
  resources :promotions
  resources :brands, only: :show
  resources :invoices do
    resources :product_invoices, only: :index
  end

  get "search" => "searches#index"
  get "contact" => "static_pages#contact"
  mount Sidekiq::Web, at: "/sidekiq"

  namespace :admin do
    resources :categories, except: :show
    resources :brands, except: :show
    resources :products
    resources :users

    post "destroy_categories" => "categories#destroy"
    post "destroy_brands" => "brands#destroy"
    post "destroy_products" => "products#destroy"
    post "destroy_users" => "users#destroy"
  end
end
