class Passwords::GenerateToken < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[email].freeze

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    user = User.find_by(email: email)

    if user.present?
      generate_token_and_mail_user(user)
    else
      return
    end
  end

  private

  def generate_token_and_mail_user(user)
      token = generate_token

      PasswordMailer.with(
        email: email,
        token: token 
      ).password_token_email.deliver_later
  end

  def generate_token
    code = SecureRandom.random_number(1_000_000_00).to_s.rjust(8, '0')
    new_token = PasswordResetToken.create(email: email, code: code)

    if new_token.persisted?
      return new_token.code
    end
  end
end
