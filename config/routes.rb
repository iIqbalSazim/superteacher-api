Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  namespace :api do
    namespace :v1 do
      post "users", to: "users#create_new_user"
      post "login", to: "sessions#login_user"

      post "classrooms", to: "classrooms#create_classroom"
      get "classrooms", to: "classrooms#get_classrooms"

      post 'generate_code', to: 'registration_codes#generate_code'
      get 'codes', to: 'registration_codes#all_codes'
      post 'code', to: 'registration_codes#validate_code'
    end
  end
end
