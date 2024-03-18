class Profiles::UpdateUserDetails < BaseInteractor

    REQUIRED_PARAMS = %i[params user_id].freeze

    USER_DOES_NOT_EXIST = "User does not exist in the database"
    FAILED_TO_UPDATE = "Failed to update user"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        user = UserRepository.find_by_id(user_id)

        if user.present?
            updated_user = UserRepository.update(user, user_params)

            if updated_user.valid?
                context.user = updated_user
            else
                context.fail!(
                    message: FAILED_TO_UPDATE
                )
            end
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
