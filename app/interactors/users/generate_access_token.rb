class Users::GenerateAccessToken
  include Interactor

  def call
    user = context.user_data
    application = Doorkeeper::Application.find_by(uid: 'v9NQGzvqsvjNM8KiJDN6pKxWE1Apv-x_5xrJ9w3SgV8')

    token_request = Doorkeeper::AccessToken.create!(
      resource_owner_id: user.id,
      application_id: application.id,
      scopes: ''
    )

    if token_request
      context.token = { access_token: token_request.token, token_type: 'Bearer' }
    else
      context.fail!(message: "Unable to create token", error: "Token creation failed", status: :internal_server_error)
    end
  end
end
