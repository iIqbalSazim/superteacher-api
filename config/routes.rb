Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  namespace :api do
    namespace :v1 do
      post "users", to: "users#create"

      post "login", to: "sessions#login"
      post "logout", to: "sessions#revoke_token"

      post "profile/teacher/:id", to: "teacher_profiles#update"
      post "profile/student/:id", to: "student_profiles#update"

      resources :classrooms, only: [:index, :create, :update, :destroy, :show] do
        resources :global_messages, only: [:index, :create], path: 'messages', controller: 'classrooms/global_messages'

        resources :students, only: [:index], controller: 'classrooms/students'

        # get "students/unenrolled", to: "classrooms/students#unenrolled_students"
        post "students/enroll", to: "classrooms/students#enroll"
        put "students/remove", to: "classrooms/students#remove"

        resources :resources, only: [:index, :create], controller: 'classrooms/resources'
      end

      # mentioned something about third party
      post "cloudinary/upload", to: "cloudinary#upload_file"
    end
  end
end
