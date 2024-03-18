class RegistrationCodeRepository < BaseRepository
    class << self
        def find_by_email(email)
            klass.find_by(email: email)
        end

        private

        def klass
            RegistrationCode
        end
    end
end