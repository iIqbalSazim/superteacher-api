class Api::V1::UsersController < BaseController
    skip_before_action :authorize_request, only: [:create]
    skip_before_action :authorize_resource

    def create
        result = Users::UserRegistrationFlow.call(user_params: user_params)

        if result.success?
            serialized_user = UserSerializer.new.serialize(result.user_data)
            
            render json: { user: serialized_user, token: result.token }, status: :ok
        else
            render json: { error: result.error, message: result.message }, status: result.status
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
end