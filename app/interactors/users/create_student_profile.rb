class Users::CreateStudentProfile
    include Interactor

    def call
        user = context.user_params
        new_user = context.new_user

        student_profile = StudentProfile.new(
            student_id: new_user.id,
            education: user[:education],
            address: user[:address]
        )

        if student_profile.save
            context.user_data = new_user
            context.profile_data = student_profile
        else
            new_user.destroy
            context.fail!(
                message: "Failed to create student profile",
                error: "User and profile creation failed",
                status: :internal_server_error
            )
        end
    end
end