Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  namespace :api do
    namespace :v1 do
      post "users", to: "users#create_new_user"
      post "login", to: "sessions#login_user"

      post 'generate_code', to: 'registration_codes#generate_code'
      get 'codes', to: 'registration_codes#all_codes'
    end
  end
end
