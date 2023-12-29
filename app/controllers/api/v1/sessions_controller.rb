class Api::V1::SessionsController < ApplicationController
    skip_before_action :doorkeeper_authorize!

    def login_user
        result = Users::LoginFlow.call(session_params: session_params)

        if result.success?
            user = result.user_data.attributes.except("password")
            render json: { user: user, message: "Login successful", token: result.token}
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end
    
    private 
    
    def session_params
        params.require(:session).permit(:email, :password)
    end
end