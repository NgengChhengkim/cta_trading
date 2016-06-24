Rails.application.routes.draw do
  devise_for :users
  root "static_pages#index"
  get "product" => "static_pages#product"
  get "products" => "static_pages#products"
end
