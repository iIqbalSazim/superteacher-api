class Api::V1::CloudinaryController < ApplicationController
    before_action :authorize_resource_actions

    def upload_file
        result = Cloudinary::UploadFile.call(params: params[:file])

        if result.success?
            render json: { url: result.url, message: "Resource upload successful" }
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    private

    def authorize_resource_actions
        if action_name == 'upload_file'
            authorize :cloudinary, :upload_file?
        end
    end
end