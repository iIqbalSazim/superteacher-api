class Users::RevokeToken < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[token].freeze

  UNABLE_TO_REVOKE_TOKEN = "Unable to revoke token"
  INVALID_TOKEN = "Invalid token"

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    token_to_revoke = Doorkeeper::AccessToken.find_by(token: token)

    if token_to_revoke.present?
      revoke_token(token_to_revoke)
    else
      context.fail!(
        message: INVALID_TOKEN,
      )
    end
  end

  private 

  def revoke_token(token)
    context.fail!(
      message: UNABLE_TO_REVOKE_TOKEN,
    ) unless token.revoke
  end
end
