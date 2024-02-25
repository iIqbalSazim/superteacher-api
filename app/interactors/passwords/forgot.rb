class Passwords::Forgot < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[email].freeze

  USER_DOES_NOT_EXIST = "User with this email does not exist"

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    user = User.find_by(email: email)

    if user.present?
      generate_new_password_and_mail_user(user)
    else
      return
    end
  end

  private

  def generate_new_password_and_mail_user(user)
      new_unique_password = generate_strong_password

      if user.update(password: new_unique_password)
        PasswordMailer.with(
          email: email,
          new_password: new_unique_password 
        ).forgot_password_email.deliver_later
      else
        context.fail!(
          message: SOMETHING_WENT_WRONG
        )
      end
  end

  def generate_strong_password
    loop do
      password = SecureRandom.urlsafe_base64(16)
      if password.match?(/(?=.*[A-Z])(?=.*[a-z])(?=.*\d)/)
        return password
      end
    end 
  end
end
