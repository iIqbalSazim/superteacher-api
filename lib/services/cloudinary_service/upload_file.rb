module Services
  module CloudinaryService
    class UploadFile
      include ::Cloudinary

      FILE_UPLOAD_FAILED = "Failed to upload file"

      def self.call(file_params)
        begin
          uploaded_file = Cloudinary::Uploader.upload(file_params)
          uploaded_file
        rescue CloudinaryException => e
          raise StandardError, FILE_UPLOAD_FAILED, e.message
        end       
      end
    end
  end
end
