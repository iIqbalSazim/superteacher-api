module Services
  module CloudinaryService
    class GenerateSignature
      include ::Cloudinary

      def self.call
        begin
          timestamp = Time.now.to_i

          signature = Cloudinary::Utils.api_sign_request({ timestamp: timestamp }, Cloudinary.config.api_secret)

          return {
            cloud_name: Cloudinary.config.cloud_name,
            api_key: Cloudinary.config.api_key,
            timestamp: timestamp,
            signature: signature
          }
        rescue CloudinaryException => e
          raise StandardError, e.message
        end       
      end
    end
  end
end
