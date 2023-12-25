class Sessions::LoginUser
    include Interactor

    def call
        user_credentials = context.session_params

        existing_user = User.find_by(email: user_credentials[:email])
        
        if existing_user && existing_user.authenticate(user_credentials[:password])
            application = Doorkeeper::Application.find_by(uid: 'zd8r1HWzyg1z3zRiR50xH9L8hzYb_D_H20HJnwCzAP8')
            token_request = Doorkeeper::AccessToken.create!(
                resource_owner_id: existing_user.id,
                application_id: application.id,
                scopes: ''
            )
            if token_request
                context.user_data = existing_user
                context.token = { access_token: token_request.token, token_type: 'Bearer' }
            else
                context.fail!(error: "Unable to create token", message: "Token creation failed", status: :internal_server_error)
            end
        else
            context.fail!(error: "Invalid email or password", message: "Login failed", status: :unauthorized)
        end
    end

    private

    def set_context_data(user)
        context.user_data = user
        context.access_token = Users::GenerateAccessToken.call(user: user).access_token 
    end
end