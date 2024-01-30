class Api::V1::TeacherProfilesController < ApplicationController
    include Panko
    before_action :authorize_teacher_profile, only: [:update_teacher_profile]

    def update_teacher_profile
        result = TeacherProfiles::UpdateTeacherProfileFlow.call(params: teacher_profile_params, id: params[:id])

        if result.success?
            serialized_teacher_profile = TeacherProfileSerializer.new.serialize(result.profile)

            render json: { profile: serialized_teacher_profile, message: "Teacher profile updated" }
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    private

    def teacher_profile_params
        params.require(:teacher_profile).permit(:email, :gender, :first_name, :last_name, :major_subject, :highest_education_level, subjects_to_teach: [])
    end

    def authorize_teacher_profile
        if action_name = "update_teacher_profile"
            authorize :teacher_profile, :update_teacher_profile?
        end
    end
end