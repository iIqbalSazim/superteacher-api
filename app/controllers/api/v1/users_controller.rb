class Api::V1::UsersController < ApplicationController

    def create_new_user
        result = Users::CreateNewUser.call(user_params: user_params)

        if result.success?
            render json: { user: result.user_data, message: "New user created" }
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :gender, :first_name, :last_name, :phone_number, :role)
    end
end