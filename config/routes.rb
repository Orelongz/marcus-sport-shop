# require 'devise_token_auth'

Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api, constraints: { format: "json" } do
    mount_devise_token_auth_for "User", at: "auth", controllers: {
      sessions: "api/user/sessions",
        registrations: "api/user/registrations"
    }

    namespace :v1 do
      resources :product_types
      resources :accessory_types

      resources :products
      resources :accessories
    end
  end
end
