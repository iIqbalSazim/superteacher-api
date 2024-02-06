class TeacherProfiles::UpdateTeacherProfile
    include Interactor

    REQUIRED_PARAMS = %i[id params].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        teacher_id = id

        teacher_profile = TeacherProfile.find_by(teacher_id: teacher_id)

        if teacher_profile
            if teacher_profile.update(
                highest_education_level: params[:highest_education_level],
                major_subject: params[:major_subject],
                subjects_to_teach: params[:subjects_to_teach]
            )
                context.profile = teacher_profile
            else
                context.fail!(
                    error: "Teacher profile failed to update",
                    message: "Something went wrong",
                    status: :unprocessable_entity
                )
            end
        else
            context.fail!(
                error: "Profile failed to update",
                message: "Teacher profile does not exist in the database",
                status: :unprocessable_entity
            )
        end
    end
end
