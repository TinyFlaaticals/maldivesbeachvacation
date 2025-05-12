Rails.application.routes.draw do
  get "offers", to: "pages#offers"
  get "about", to: "pages#about"
  get "contact", to: "pages#contact"
  post "contact", to: "pages#submit_contact"

  resources :stories, only: [ :index, :show ]
  resources :bookings, only: [ :show ]

  resources :hotels, only: [ :index, :show ]
  resources :properties, only: [ :index, :show ] do
    # resources :bookings, only: [ :new, :create ]
    member do
      post "bookings", to: "properties#create_booking"
    end
  end

  devise_for :admins


  get "admins", to: "admin/properties#index"
  namespace :admin do
    get "/" => "properties#index"
    get "dashboard", to: "pages#dashboard", as: :root
    resources :hotels
    resources :properties do
      resources :room_categories, except: [ :index ]
    end
    resources :popular_filters
    resources :facilities
    resources :activities
    resources :bookings do
      collection do
        delete :clear_all
      end
    end
    resources :stories do
      member do
        delete :remove_image
      end
    end
    resources :popular_properties
    resource :admin_config, only: [ :show, :edit, :update ] do
      member do
        delete :remove_about_image
        delete :remove_hero_image
        delete :remove_middle_image
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root "pages#home"
end
