class Users::ValidateRegistrationCode < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[user_params].freeze

    VALIDATION_ATTEMPTS_EXCEEDED = "Validation attempts exceeded. Please contact the admin."
    INVALID_CODE = "Invalid registration code. Please try again or contact the admin."

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        return unless user_params[:role] == "teacher"

        existing_code = RegistrationCode.find_by(email: user_params[:email])

        handle_code_does_not_exist unless existing_code.present?

        validate_attempts(existing_code)
    end

    private

    def validate_attempts(existing_code)
        if existing_code.attempts_count > 0
            if existing_code.code == user_params[:code]
                context.code = existing_code.code
                existing_code.update!(is_used: true, attempts_count: 0)
            else
                existing_code.update!(attempts_count: existing_code.attempts_count - 1)

                handle_invalid_code(existing_code.attempts_count)
            end
        else
            context.fail!(
                message: VALIDATION_ATTEMPTS_EXCEEDED,
                attempts_remaining: 0,
                status: :forbidden
            )
        end 
    end

    def handle_code_does_not_exist
        context.fail!(
            message: INVALID_CODE,
            status: :unprocessable_entity
        )
    end

    def handle_invalid_code(attempts_remaining)
        context.fail!(
            message: INVALID_CODE,
            attempts_remaining: attempts_remaining, 
            status: :unprocessable_entity
        )
    end
end
