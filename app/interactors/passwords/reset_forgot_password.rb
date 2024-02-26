class Passwords::ResetForgotPassword < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[params token].freeze

  USER_NOT_FOUND_ERROR = "User not found"
  FAILED_UPDATE_ERROR = "Failed to update password, please try again"
  INVALID_CODE_ERROR = "Invalid or already used code. Please try again."

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    user = User.find_by(email: params["email"])

    if user.present?
      handle_existing_token(user)
    else
      context.fail!(message: USER_NOT_FOUND_ERROR)
    end
  end

  private

  def handle_existing_token(user)
    existing_token = PasswordResetToken.find_by(email: user[:email], code: token)

    if existing_token.present? && !existing_token[:is_used]
      update_password(user, existing_token)
    else
      context.fail!(message: INVALID_CODE_ERROR)
    end
  end

  def update_password(user, token)
    if user.update(password: params["new_password"])
      token.update(is_used: true)
      return
    else
      context.fail!(message: FAILED_UPDATE_ERROR)
    end
  end
end
