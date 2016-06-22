Rails.application.routes.draw do
  root "static_pages#index"
  get "product" => "static_pages#product"
  get "products" => "static_pages#products"
end
