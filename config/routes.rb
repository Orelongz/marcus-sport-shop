# require 'devise_token_auth'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "up" => "rails/health#show", :as => :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api, constraints: { format: "json" } do
    mount_devise_token_auth_for "User", at: "auth", controllers: {
      sessions: "api/user/sessions",
        registrations: "api/user/registrations"
    }, defaults: { format: :json }

    namespace :v1 do
      resources :product_types, except: %i[new edit]
      resources :accessory_types, except: %i[new edit]

      resources :products, except: %i[new edit]
      resources :accessories, except: %i[new edit]
      resources :cart_items, except: %i[new edit]
    end
  end
end
