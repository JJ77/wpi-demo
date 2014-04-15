Wpi::Application.routes.draw do
  resources :entries

  resources :plants

  resources :beds

  resources :greenhouses

  resources :locations

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end