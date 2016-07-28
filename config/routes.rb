require "sidekiq/web"

Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "registrations"}
  root "static_pages#index"

  resources :product_carts, only: [:index, :create, :update, :destroy]
  resources :product_invoices, only: [:new, :create, :destroy]
  resources :guests, only: :create
  resources :categories, only: :show do
    resources :brands, only: :show
  end
  resources :products, only: :show
  resources :promotions
  resources :brands, only: :show do
    resources :categories, only: :show
  end
  resources :invoices, only: [:index, :show]

  get "search" => "searches#index"
  get "contact" => "static_pages#contact"
  mount Sidekiq::Web, at: "/sidekiq"

  namespace :admin do
    root to: "invoices#index"
    resources :categories, except: [:show, :destroy]
    resources :brands, except: [:show, :destroy]
    resources :products, except: :destroy
    resources :users, except: :destroy
    resources :guests, only: [:index, :show]
    resources :promotions, except: :destroy
    resources :slide_images, except: :destroy
    resources :contacts, only: [:index, :edit, :update]
    resources :invoices, only: [:index, :show, :update]

    post "destroy_categories" => "categories#destroy"
    post "destroy_brands" => "brands#destroy"
    post "destroy_products" => "products#destroy"
    post "destroy_users" => "users#destroy"
    post "destroy_guests" => "guests#destroy"
    post "destroy_promotions" => "promotions#destroy"
    post "destroy_slide_images" => "slide_images#destroy"
    post "destroy_invoices" => "invoices#destroy"
  end
end
