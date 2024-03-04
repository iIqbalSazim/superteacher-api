class Api::V1::CloudinaryController < BaseController

    def generate_signature
        result = Cloudinary::GenerateSignature.call

        if result.success?
            render json: { sign_data: result.sign_data }, status: :ok
        else
            render json: { message: "Failed to generate signature" },  status: :unprocessable_entity
        end
    end

    private

    def resource_model
        :cloudinary
    end
end