Wpi::Application.routes.draw do
  resources :projections, only: [:index]

  resources :entries do
  	member do
  		delete :wipe
  	end
    collection do
      get :projection_queue
      put :projection_conversion
    end
	end

  resources :plants

  resources :beds

  resources :greenhouses

  resources :locations

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end
