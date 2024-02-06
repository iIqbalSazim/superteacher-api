class Users::CreateNewUser < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[user_params].freeze

    USER_ALREADY_EXISTS = "User with this email already exists"
    FAILED_TO_SAVE_USER = "Failed to save user"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        if user_already_exists?
            context.fail!(
                message: USER_ALREADY_EXISTS,
                status: :unprocessable_entity
            )
        else
            create_and_save_new_user
        end
    end

    private

    def user_already_exists?
        User.exists?(email: user_params[:email])
    end

    def create_and_save_new_user
        new_user = User.new(new_user_params)

        if new_user.save
            context.user_data = new_user
        else
            context.fail!(
                message: FAILED_TO_SAVE_USER,
                status: :unprocessable_entity
            )
        end
    end

    def new_user_params
        user_params.slice(:email, :password, :first_name, :last_name, :gender, :phone_number, :role)
    end
end