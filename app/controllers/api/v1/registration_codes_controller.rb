class Api::V1::RegistrationCodesController < ApplicationController
    def generate_code
        unused_codes = RegistrationCode.where(is_used: false)
        if unused_codes.length == 0
            generated_code = `rake registration_code:generate`.strip

            render json: { code: generated_code, message: "Code generated successfully." }
        else
            render json: { message: "Failed to generate new code. There are unused codes in the database." }
        end
    end

    def all_codes
        unused_codes = RegistrationCode.where(is_used: false).pluck(:code)

        if unused_codes.length == 0
            render json: { message: "No codes are available. Please generate new code."}
        else
            render json: { codes: unused_codes, message: "Codes retrieved successfully." }
        end
    end
end