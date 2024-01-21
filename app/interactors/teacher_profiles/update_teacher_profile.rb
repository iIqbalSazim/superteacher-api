class TeacherProfiles::UpdateTeacherProfile
    include Interactor

    def call
        teacher_id = context.user_id

        teacher_profile = TeacherProfile.find_by(teacher_id: teacher_id)

        if teacher_profile
            if teacher_profile.update(
                highest_education_level: context.params[:highest_education_level],
                major_subject: context.params[:major_subject],
                subjects_to_teach: context.params[:subjects_to_teach]
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
