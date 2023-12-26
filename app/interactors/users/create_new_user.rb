class Users::CreateNewUser
    include Interactor

    def call
        user = context.user_params

        if existing_user = User.find_by(email: user[:email])
            context.fail!(
                message: "User with this email already exists",
                error: "User creation failed",
                status: :unprocessable_entity
            )
        else
            new_user = User.new(
                email: user[:email],
                password: user[:password],
                first_name: user[:first_name],
                last_name: user[:last_name],
                gender: user[:gender],
                phone_number: user[:phone_number],
                role: user[:role]
            )

            if new_user.save
                context.new_user = new_user
            else
                context.fail!(
                    error: "Something went wrong!",
                    message: "User failed to save.",
                    status: :internal_server_error
                )
            end
        end
    end
end
