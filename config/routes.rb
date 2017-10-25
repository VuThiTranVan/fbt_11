Rails.application.routes.draw do
  root "static_pages#show", url_page: "home"

  resources :users
  resources :travels, only: [:show, :search]
  resources :ratings, only: [:action_rating]

  get "signup" => "users#new"
  post "signup" => "users#create"
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"
  get "sessions/new"

  post "/action_rating" => "ratings#action_rating"
  get "/search" => "travels#search"
end
