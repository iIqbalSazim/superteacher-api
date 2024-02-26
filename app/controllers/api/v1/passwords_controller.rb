class Api::V1::PasswordsController < BaseController
    skip_before_action :authorize_request, only: [:token, :validate, :reset_forgot]
    skip_before_action :authorize_resource, only: [:token, :validate, :reset_forgot]

    def reset
        result = Passwords::Reset.call(params: password_params,
                                       current_user: current_user)

        if result.success?
            render json: { message: "Password reset successful" }, status: :ok
        else
            render json: { message: result.message }, status: :unprocessable_entity
        end
    end

    def token
        result = Passwords::GenerateToken.call(email: params[:email])

        if result.success?
            render status: :ok
        end
    end

    def validate
        result = Passwords::ValidateToken.call(token: params[:token],
                                               email: params[:email])

        if result.success?
            render status: :ok
        else
            render json: { message: "Invalid code. Please try again" }, status: :unprocessable_entity
        end
    end
    
    def reset_forgot
        result = Passwords::ResetForgotPassword.call(token: params[:token],
                                                     params: password_params)

        if result.success?
            render json: { message: "Password successfully reset" }, status: :ok
        else
            render json: {message: result.message}, status: :unprocessable_entity
        end
    end
    
    private 
    
    def password_params
        params.require(:password).permit(:new_password, :old_password, :email)
    end

    def resource_model
        :password
    end
end