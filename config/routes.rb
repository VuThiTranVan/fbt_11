Rails.application.routes.draw do
  root "static_pages#show", page: "home"
end
