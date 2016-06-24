Rails.application.routes.draw do
  devise_for :users
  root "static_pages#index"
  get "cart" => "static_pages#cart"
end
