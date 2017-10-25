Rails.application.routes.draw do
  root "static_pages#show", page: "home"

  resources :users

  get "signup" =>"users#new"
  post "signup" =>"users#create"
end
