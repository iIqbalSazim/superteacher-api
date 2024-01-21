class StudentProfiles::UpdateStudentProfile
    include Interactor

    def call
        student_id = context.user_id

        student_profile = StudentProfile.find_by(student_id: student_id)

        if student_profile
            if student_profile.update(
                education: context.params[:education],
                address: context.params[:address]
            )
                context.profile = student_profile
            else
                context.fail!(
                    error: "Student profile failed to update",
                    message: "Something went wrong",
                    status: :unprocessable_entity
                )
            end
        else
            context.fail!(
                error: "Profile failed to update",
                message: "Student profile does not exist in the database",
                status: :unprocessable_entity
            )
        end
    end
end
