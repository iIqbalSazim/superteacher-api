class Api::V1::CloudinaryController < BaseController

    def upload_file
        result = Cloudinary::UploadFile.call(params: params[:file])

        if result.success?
            render json: { url: result.url }, status: :ok
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    private

    def resource_model
        :cloudinary
    end
end