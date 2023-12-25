class RegistrationCodes::AllCodes
    include Interactor

    def call
        unused_codes = RegistrationCode.where(is_used: false).pluck(:code)

        if unused_codes.length == 0
            context.fail!( error: "Failed to retrieve codes", message: "No codes are available. Please generate new code." )
        else
            context.codes = unused_codes
        end
    end
end