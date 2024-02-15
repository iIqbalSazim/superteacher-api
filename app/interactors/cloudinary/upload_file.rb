class Cloudinary::UploadFile < BaseInteractor
    include Interactor
    include Services::CloudinaryService

    REQUIRED_PARAMS = %i[file_params].freeze

    FAILED_TO_UPLOAD = "Failed to upload file"

    delegate(*REQUIRED_PARAMS, to: :context) 

    def call
        validate_params REQUIRED_PARAMS

        uploaded_file = UploadFile.call(file_params)

        if uploaded_file.present?
            context.url = uploaded_file["url"]
        else
            context.fail!(
                message: FAILED_TO_UPLOAD
            )
        end
    end
end
