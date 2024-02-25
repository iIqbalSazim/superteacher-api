module Services
  module CloudinaryService
    class UploadFile
      include ::Cloudinary

      def self.call(file_params)
        begin
          uploaded_file = Cloudinary::Uploader.upload(file_params)
          uploaded_file
        rescue CloudinaryException => e
          raise StandardError, e.message
        end       
      end
    end
  end
end
