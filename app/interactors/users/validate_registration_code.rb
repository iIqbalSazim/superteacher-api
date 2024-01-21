class Users::ValidateRegistrationCode
    include Interactor

    def call
        code = context.user_params[:code]
        email = context.user_params[:email]

        existing_code = RegistrationCode.find_by(email: email)

        if existing_code
            if existing_code.attempts_count > 0
                if existing_code.code == code
                    context.code = existing_code.code
                    existing_code.update!(is_used: true, attempts_count: 0)
                else
                    existing_code.update!(attempts_count: existing_code.attempts_count - 1)
                    context.fail!(
                        error: "Failed to validate code",
                        message: "Invalid registration code. Please try again.",
                        status: :unprocessable_entity
                    )
                end
            else
                context.fail!(
                    error: "Failed to validate code",
                    message: "Validation attempts exceeded. Please contact the admin.",
                    status: :forbidden
                )
            end
        else
            context.fail!(
                error: "Failed to validate code",
                message: "Invalid code.",
                status: :unprocessable_entity
            )
        end
    end
end
