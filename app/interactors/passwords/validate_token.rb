class Passwords::ValidateToken < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[email token].freeze

  delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        existing_token = PasswordResetToken.find_by(email: email, code: token)

        if existing_token.present? && !existing_token[:is_used]
            return
        else
            context.fail!
        end
    end
end
