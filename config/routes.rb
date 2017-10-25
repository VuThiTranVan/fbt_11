Rails.application.routes.draw do
  root "static_pages#show", page: "home"

  resources :users

  get "signup" => "users#new"
  post "signup" => "users#create"
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"
  get "sessions/new"
end
