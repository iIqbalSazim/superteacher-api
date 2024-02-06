class Users::AuthenticateUser
  include Interactor

  REQUIRED_PARAMS = %i[user_params].freeze

  INVALID_CREDENTIALS = "Invalid email or password"

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    existing_user = User.find_by(email: user_params[:email])

    if existing_user && existing_user.authenticate(user_params[:password])
        context.user_data = existing_user
    else
      context.fail!(message: INVALID_CREDENTIALS)
    end
  end
end
