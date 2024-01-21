class Api::V1::UsersController < ApplicationController
    include Panko
    before_action :authorize_user_actions
    skip_before_action :doorkeeper_authorize!, only: [:create_new_user]

    def create_new_user
        case user_params[:role]
        when "student"
            result = Users::StudentRegistrationFlow.call(user_params: user_params)
        when "teacher"
            result = Users::TeacherRegistrationFlow.call(user_params: user_params)
        end

        if result.success?
            serialized_user = UserSerializer.new.serialize(result.user_data)

            render json: { user: serialized_user, message: "New user created", token: result.token }
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    def get_unenrolled_students
        result = Users::GetUnenrolledStudents.call(classroom_id: params[:classroom_id])

        if result.success?
            serialized_students = ArraySerializer.new(result.students, each_serializer: UserSerializer).to_a
            render json: { students: serialized_students, message: "Students retrieved succesfully" }
        else
            render json: { error: result.error }, status: result.status
        end
    end

    private

    def user_params
        params.require(:user).permit(
            :email, :password, :gender, :first_name, :last_name, :phone_number, :role,
            :code,
            :address,
            :major_subject,
            :highest_education_level,
            subjects_to_teach: [],
            education: [
                :level, :english_bangla_medium, :class_level, :degree_level, :semester_year
            ],
        )
    end

    def authorize_user_actions
        if action_name == 'get_unenrolled_students'
            authorize :user, :get_unenrolled_students?
        end
    end
end