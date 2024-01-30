class Api::V1::StudentProfilesController < ApplicationController
    include Panko
    before_action :authorize_student_profile, only: [:update_student_profile]

    def update_student_profile
        result = StudentProfiles::UpdateStudentProfileFlow.call(params: student_profile_params, id: params[:id])

        if result.success?
            serialized_student_profile = StudentProfileSerializer.new.serialize(result.profile)

            render json: { profile: serialized_student_profile, message: "Student profile updated" }
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    private

    def student_profile_params
        params.require(:student_profile).permit(
            :email, :gender, :first_name, :last_name, :address, :phone_number, 
            education: [
                :level, :english_bangla_medium, :class_level, :degree_level, :semester_year
            ]
        )
    end

    def authorize_student_profile
        if action_name = "update_student_profile"
            authorize :student_profile, :update_student_profile?
        end
    end
end