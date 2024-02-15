Rails.application.routes.draw do
  scope 'api/v1' do
    use_doorkeeper do
      # it accepts :authorizations, :tokens, :applications and :authorized_applications
      skip_controllers :applications, :authorized_applications, :authorizations
    end
  end

  namespace :api do
    namespace :v1 do
      post "users", to: "users#create"

      post "profiles/:id", to: "profiles#update"

      post "login", to: "sessions#login"
      post "logout", to: "sessions#revoke_token"

      resources :classrooms, only: [:index, :create, :update, :destroy, :show] do
        resources :global_messages, only: [:index, :create], path: 'messages', controller: 'classrooms/global_messages'

        resources :students, only: [:index], controller: 'classrooms/students'

        post "students/enroll", to: "classrooms/students#enroll"
        put "students/remove", to: "classrooms/students#remove"

        resources :resources, only: [:index, :create], controller: 'classrooms/resources'

        resources :exams, only: [:index, :create], controller: 'classrooms/exams'
      end

      post "cloudinary/upload", to: "cloudinary#upload_file"
    end
  end
end
