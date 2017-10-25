Rails.application.routes.draw do
  root "static_pages#show", url_page: "home"

  resources :users
  resources :travels, only: [:show]

  get "signup" => "users#new"
  post "signup" => "users#create"
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"
  get "sessions/new"
end
