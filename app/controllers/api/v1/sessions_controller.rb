class Api::V1::SessionsController < BaseController
    skip_before_action :authorize_request, only: [:login]
    skip_before_action :authorize_resource

    def login
        result = Users::LoginFlow.call(session_params: session_params)

        if result.success?
            serialized_user = UserSerializer.new.serialize(result.user_data)
            
            render json: { user: serialized_user, token: result.token}, status: :ok
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end
    
    def revoke_token
        result = Users::RevokeToken.call(token: params[:token])

        if result.success?
            render json: { message: "Token successfully revoked" }, status: :ok
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end
    
    private 
    
    def session_params
        params.require(:session).permit(:email, :password)
    end
end