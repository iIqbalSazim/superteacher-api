class Api::V1::CloudinaryController < BaseController

    def upload_file
        result = Cloudinary::UploadFile.call(file_params: params[:file])

        if result.success?
            render json: { url: result.url }, status: :ok
        else
            render json: { message: result.message }, status: :unprocessable_entity
        end
    end

    private

    def resource_model
        :cloudinary
    end
end