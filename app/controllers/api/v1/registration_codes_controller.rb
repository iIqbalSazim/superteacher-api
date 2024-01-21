class Api::V1::RegistrationCodesController < ApplicationController
    skip_before_action :doorkeeper_authorize!

    def generate_code
        result = RegistrationCodes::GenerateCode.call(email: params[:email])

        if result.success?
            render json: { code: result.code, user: result.email, message: "Code generated successfully" }
        else
            render json: { error: result.error, message: result.message, }
        end
    end

    def all_codes
        result = RegistrationCodes::AllCodes.call

        if result.success?
            render json: { codes: result.codes, message: "Codes retrieved successfully" }
        else
            render json: { error: result.error, message: result.message }
        end
    end

    def validate_code
        result = RegistrationCodes::ValidateCode.call(code: params[:code])

        if result.success?
            render json: { code: result.code, message: "Code validation successful" }
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end
end