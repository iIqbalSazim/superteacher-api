class Shared::UpdateUserDetails
    include Interactor

    def call
        user = User.find_by(id: context.id)

        if user
            if user.update(
                email: context.params[:email],
                first_name: context.params[:first_name],
                last_name: context.params[:last_name],
                gender: context.params[:gender],
                phone_number: context.params[:phone_number]
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
