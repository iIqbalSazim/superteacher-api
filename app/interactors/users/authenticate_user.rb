class Users::AuthenticateUser < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[user_params].freeze

  INVALID_CREDENTIALS = "Invalid email or password"

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    existing_user = User.find_by(email: user_params[:email])

    if existing_user && existing_user.authenticate(user_params[:password])
        context.user_data = existing_user
    else
      context.fail!(message: INVALID_CREDENTIALS)
    end
  end
end
