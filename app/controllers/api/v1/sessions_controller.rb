class Api::V1::SessionsController < ApplicationController

    def login_user
        result = Users::LoginFlow.call(session_params: session_params)

        if result.success?
            render json: { user: result.user_data, message: "Login successful", token: result.token}
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end
    
    private 
    
    def session_params
        params.require(:session).permit(:email, :password)
    end
end