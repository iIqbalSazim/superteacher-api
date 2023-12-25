class Users::CreateNewUser
  include Interactor

    def call
        user = context.user_params

        existing_user = User.find_by(email: user[:email])

        if existing_user
            context.fail!( error: "Email already exists", message: "User creation failed", status: :unprocessable_entity )
        else
            new_user = User.create!(user)
            if new_user.save
                context.user_data = new_user
            else
                context.fail!( error: "Something went wrong!", message: "User failed to save.", status: :internal_server_error )
            end
        end
    end
end