Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  namespace :api do
    namespace :v1 do
      get "users/students", to: "users#get_unenrolled_students"
      post "users", to: "users#create_new_user"
      post "login", to: "sessions#login_user"
      post "logout", to: "sessions#revoke_token"

      get "students", to: "classroom_students#get_students"
      post "enroll", to: "classroom_students#enroll_student"
      delete "classrooms/students", to: "classroom_students#remove_student"

      get "classrooms", to: "classrooms#get_classrooms"
      post "classrooms", to: "classrooms#create_classroom"
      put "classrooms/:id", to: "classrooms#update_classroom"
      delete "classrooms/:id", to: "classrooms#delete_classroom"

      post "cloudinary/upload", to: "cloudinary#upload_file"

      get "resources", to: "resources#get_resources"
      post "resources", to: "resources#create_resource"

      get "stream", to: "classroom_global_messages#get_messages"
      post "stream/message", to: "classroom_global_messages#create_message"

      post "generate_code", to: "registration_codes#generate_code"
      get "codes", to: "registration_codes#all_codes"
      post "code", to: "registration_codes#validate_code"
    end
  end
end
