class Users::CreateTeacherProfile
    include Interactor

    REQUIRED_PARAMS = %i[user_params new_user].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        teacher_profile = TeacherProfile.new(
            teacher_id: new_user.id,
            highest_education_level: user_params[:highest_education_level],
            major_subject: user_params[:major_subject],
            subjects_to_teach: user_params[:subjects_to_teach]
        )

        if teacher_profile.save
            context.user_data = new_user
            context.profile_data = teacher_profile
        else
            new_user.destroy
            context.fail!(
                message: "Failed to create teacher profile",
                error: "User and profile creation failed",
                status: :internal_server_error
            )
        end
    end
end