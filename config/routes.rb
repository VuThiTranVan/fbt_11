Rails.application.routes.draw do
  root "static_pages#show", url_page: "home"

  devise_for :users

  namespace :admin do
    resources :book_tours, only: [:index, :show, :update]
    resources :travels do
      resources :ratings, only: :index
    end
  end

  resources :users do
    resources :book_tours, only: [:index, :update]
  end
  resources :travels, only: [:show, :search] do
    resources :book_tours, only: [:new, :create, :show]
  end
  resources :ratings, only: [:action_rating]

  post "/action_rating" => "ratings#action_rating"
  get "/search" => "travels#search"
end
