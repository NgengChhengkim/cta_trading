Rails.application.routes.draw do
  devise_for :users
  root "static_pages#index"
  resources :product_carts
end
