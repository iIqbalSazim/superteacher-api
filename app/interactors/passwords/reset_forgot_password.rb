class Passwords::ResetForgotPassword < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[params token].freeze

  USER_NOT_FOUND_ERROR = "User not found"
  FAILED_UPDATE_ERROR = "Failed to update password, please try again"
  INVALID_CODE_ERROR = "Invalid or already used code. Please try again."

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    user = UserRepository.find_user_by_email(params["email"])

    if user.present?
      handle_existing_token(user)
    else
      context.fail!(message: USER_NOT_FOUND_ERROR)
    end
  end

  private

  def handle_existing_token(user)
    existing_token = PasswordResetTokenRepository.find_by_email_and_code(user[:email], token)

    if existing_token.present? && !existing_token[:is_used]
      update_password(user, existing_token)
    else
      context.fail!(message: INVALID_CODE_ERROR)
    end
  end

  def update_password(user, token)
    updated_user = UserRepository.update(user, { password: params["new_password"] })

    if updated_user.valid?
      PasswordResetTokenRepository.update(token, { is_used: true })
      return
    else
      context.fail!(message: FAILED_UPDATE_ERROR)
    end
  end
end
