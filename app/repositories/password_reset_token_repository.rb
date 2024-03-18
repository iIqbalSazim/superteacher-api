class PasswordResetTokenRepository < BaseRepository
    class << self
        def find_by_email_and_code(email, code)
            klass.find_by(email: email, code: code)
        end

        def create_token_with_email(email, code)
            klass.create(email: email, code: code)
        end

        private

        def klass
            PasswordResetToken
        end
    end
end