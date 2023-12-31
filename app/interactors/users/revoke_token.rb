class Users::RevokeToken
  include Interactor

  def call
    token = context.token

    token_to_revoke = Doorkeeper::AccessToken.find_by(token: token)
    if token_to_revoke.present?
      token_to_revoke.update(revoked_at: Time.now)
    else
      context.fail!(error: "Unable to revoke token", message: "Invalid token", status: :unprocessable_entity)
    end
  end
end