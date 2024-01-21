class RegistrationCodes::GenerateCode
    include Interactor

    def call
        ENV['EMAIL'] = context.email

        generated_code = `rake registration_code:generate`.strip

        ENV.delete('EMAIL')

        if generated_code
            context.code = generated_code
        else
            context.fail!(message: "Failed to generate new code", error: "New code generation failed")
        end
    end
end