class Cloudinary::GenerateSignature < BaseInteractor
    include Interactor
    include Services::CloudinaryService

    def call
        sign_data = GenerateSignature.call

        if sign_data.present?
            context.sign_data = sign_data
        else
            context.fail!
        end
    end
end
