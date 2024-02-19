class Api::V1::ProfilesController < BaseController

    def update
        result = Profiles::UpdateProfileFlow.call(params: profile_params,
                                                current_user: current_user)

        if result.success?
            serialized_user = UserSerializer.new.serialize(result.user)

            render json: { user: serialized_user }, status: :ok
        else
            render json: { message: result.message }, status: :unprocessable_entity
        end
    end

    private

    def profile_params
        if current_user.teacher?
            params.require(:profile).permit(
                :first_name,
                :last_name,
                :gender,
                :address,
                :education,
                :highest_education_level,
                :major_subject,
                subjects_to_teach: []
            )
        elsif current_user.student?
            params.require(:profile).permit(
                :first_name,
                :last_name,
                :gender,
                :phone_number,
                :address,
                education: [
                    :level,
                    :english_bangla_medium,
                    :class_level,
                    :degree_level,
                    :semester_year
                ]
            )
        end
    end

    def resource_model
        :profile
    end
end
