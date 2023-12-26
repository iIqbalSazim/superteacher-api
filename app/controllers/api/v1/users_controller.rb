class Api::V1::UsersController < ApplicationController

    def create_new_user
        case user_params[:role]
        when "student"
            result = Users::StudentRegistrationFlow.call(user_params: user_params)
        when "teacher"
            result = Users::TeacherRegistrationFlow.call(user_params: user_params)
        end

        if result.success?
            render json: { user: result.user_data, message: "New user created", token: result.token }
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    private

    def user_params
        params.require(:user).permit(
            :email, :password, :gender, :first_name, :last_name, :phone_number, :role,
            :address,
            :major_subject,
            :highest_education_level,
            subjects_to_teach: [],
            education: [
                :level, :english_bangla_medium, :class_level, :degree_level, :semester_year
            ],
        )
    end
end