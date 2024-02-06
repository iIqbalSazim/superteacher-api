class Cloudinary::UploadFile < BaseInteractor
    include Interactor
    include Cloudinary

    REQUIRED_PARAMS = %i[params].freeze

    FILE_UPLOAD_FAILED = "Failed to upload file"

    delegate(*REQUIRED_PARAMS, to: :context) 

    def call
        validate_params REQUIRED_PARAMS

        file = context.params

        begin
            uploaded_file = Cloudinary::Uploader.upload(file)
            context.url = uploaded_file["url"]
        rescue CloudinaryException => e
            handle_upload_failure(e)
        end
    end

    private

    def handle_upload_failure(exception)
        context.fail!(
            error: FILE_UPLOAD_FAILED,
            message: exception.message,
            status: :internal_server_error
        )
    end
end
