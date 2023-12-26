class RegistrationCodes::ValidateCode
    include Interactor

    def call
        code = context.code

        if existing_code = RegistrationCode.find_by(code: code)
            if existing_code.is_used == false
                context.code = existing_code.code
                existing_code.update!(is_used: true)
            else
                context.fail!(error: "Failed to validate code", message: "Code already in use.", status: :forbidden)
            end
        else
            context.fail!(error: "Failed to validate code", message: "Invalid code.", status: :unprocessable_entity)
        end
    end
end