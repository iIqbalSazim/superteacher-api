class Profiles::UpdateUserDetails < BaseInteractor

    REQUIRED_PARAMS = %i[params current_user].freeze

    PROFILE_FAILED_TO_UPDATE = "Profile failed to update"
    USER_DOES_NOT_EXIST = "User does not exist in the database"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        user = User.find_by(id: current_user.id)

        if user.present?
            user.update(user_params)

            context.user = user
        else
            context.fail!(
                message: USER_DOES_NOT_EXIST, 
            ) 
        end
    end

    private

    def user_params
        params.permit(:first_name, :last_name, :gender, :phone_number)
    end
end
