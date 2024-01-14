class Cloudinary::UploadFile
    include Interactor
    include Cloudinary

    def call
        file = context.params

        if uploaded_file = Cloudinary::Uploader.upload(file)
            context.url = uploaded_file["url"]
        else
            context.fail!(
                error: "Something went wrong!",
                message: "File failed to upload.",
                status: :internal_server_error
            )
        end
    end
end