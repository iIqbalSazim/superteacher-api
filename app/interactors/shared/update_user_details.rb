class Shared::UpdateUserDetails
    include Interactor

    REQUIRED_PARAMS = %i[params id].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        user = User.find_by(id: id)

        if user
            if user.update(
                email: params[:email],
                first_name: params[:first_name],
                last_name: params[:last_name],
                gender: params[:gender],
                phone_number: params[:phone_number]
            )
                context.user_id = user.id
            else
                context.fail!(
                    error: "User details failed to update",
                    message: "Something went wrong",
                    status: :unprocessable_entity
                )
            end
        else
            context.fail!(
                error: "Profile failed to update",
                message: "User does not exist in the database",
                status: :unprocessable_entity
            )
        end
    end
end
