class Users::CreateStudentProfile
    include Interactor

    REQUIRED_PARAMS = %i[user_params new_user].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        student_profile = StudentProfile.new(
            student_id: new_user.id,
            education: user_params[:education],
            address: user_params[:address]
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