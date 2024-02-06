class Users::GenerateAccessToken < BaseInteractor
  include Interactor

    REQUIRED_PARAMS = %i[user_data].freeze

    TOKEN_CREATION_FAILED = "Token creation failed"
    UNABLE_TO_CREATE_TOKEN = "Unable to create token"

    delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params(REQUIRED_PARAMS)

    token_request = create_access_token(user_data[:id])

    if token_request
      context.token = token_request.token
    else
      handle_token_creation_failure
    end
  end

  private 

  def create_access_token(user_id)
    Doorkeeper::AccessToken.create!(
      resource_owner_id: user_id,
      application_id: 1,
      scopes: ''
    )
  end

  def handle_token_creation_failure
    context.fail!(
      message: UNABLE_TO_CREATE_TOKEN,
      error: TOKEN_CREATION_FAILED,
      status: :internal_server_error
    )
  end

end
