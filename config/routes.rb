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

      resources :profiles, only: [:update]

      put "passwords/reset", to: "passwords#reset"
      post "passwords/forgot/token", to: "passwords#token"
      post "passwords/forgot/validate", to: "passwords#validate"
      put "passwords/forgot/reset", to: "passwords#reset_forgot"

      post "login", to: "sessions#login"
      post "logout", to: "sessions#revoke_token"

      resources :classrooms, only: [:index, :create, :update, :destroy, :show] do
        resources :global_messages, only: [:index, :create], path: 'messages', controller: 'classrooms/global_messages'

        resources :students, only: [:index], controller: 'classrooms/students'

        post "students/enroll", to: "classrooms/students#enroll"
        put "students/remove", to: "classrooms/students#remove"

        resources :resources, only: [:index, :create, :update, :destroy], controller: 'classrooms/resources'

        resources :exams, only: [:index, :create, :update, :destroy], controller: 'classrooms/exams'

        resources :assignments, only: [] do
          resources :submissions, only: [:index, :create, :destroy], controller: 'classrooms/assignments/submissions'
        end
      end

      post "upload/signature", to: "cloudinary#generate_signature"
    end
  end
end
