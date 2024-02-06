class Shared::UpdateUserDetails < BaseInteractor

    REQUIRED_PARAMS = %i[params id].freeze

    PROFILE_FAILED_TO_UPDATE = "Profile failed to update"
    USER_DOES_NOT_EXIST = "User does not exist in the database"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        user = User.find_by(id: user_id)

        update_user_details(user)
    end

    private

    def update_user_details(user)
        handle_non_existing_user unless user.present?

        handle_profile_failed_to_update unless user.update(user_params)

        context.user = user
    end

    def handle_non_existing_user
        context.fail!(
            message: USER_DOES_NOT_EXIST, 
            status: :unprocessable_entity
        )
    end

    def handle_profile_failed_to_update
        context.fail!(
            message: PROFILE_FAILED_TO_UPDATE, 
            status: :unprocessable_entity
        )
    end

    def user_params
        params.slice(:email, :first_name, :last_name, :gender, :phone_number)
    end
end
