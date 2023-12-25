class RegistrationCodes::GenerateCode
    include Interactor

    def call
        unused_codes = RegistrationCode.where(is_used: false)

        if unused_codes.length == 0
            generated_code = `rake registration_code:generate`.strip

            if generated_code
                context.code = generated_code
            else
                context.fail!(error: "Failed to generate new code", message: "New code generation failed")
            end
        else
            context.fail!(error: "Failed to generate new code", message: "There are unused codes in the database.")
        end
    end
end