class Api::V1::PasswordsController < BaseController
    skip_before_action :authorize_request, only: [:forgot]
    skip_before_action :authorize_resource, only: [:forgot]

    def reset
        result = Passwords::ResetFlow.call(params: password_params,
                                           current_user: current_user)

        if result.success?
            render json: { message: "Password reset successful" }, status: :ok
        else
            render json: { message: result.message }, status: :unprocessable_entity
        end
    end
    
    def forgot
        result = Passwords::ForgotFlow.call(email: password_params[:email])

        if result.success?
            render json: { message: "Email sent" }, status: :ok
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