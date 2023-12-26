class Users::AuthenticateUser
  include Interactor

  def call
    user_email = context.session_params[:email]
    password = context.session_params[:password]

    existing_user = User.find_by(email: user_email)

    if existing_user && existing_user.authenticate(password)
        context.user_data = existing_user
    else
      context.fail!(message: "Invalid email or password", error: "Login failed", status: :unauthorized)
    end
  end
end
