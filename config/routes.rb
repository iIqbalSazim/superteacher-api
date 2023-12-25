Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'generate_code', to: 'registration_codes#generate_code'
      get 'codes', to: 'registration_codes#all_codes'
    end
  end
end
