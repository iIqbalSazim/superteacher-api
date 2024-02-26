class PasswordMailer < ApplicationMailer
    def password_token_email
        @email = params[:email]
        @token = params[:token]

        mail(to: @email, subject: "Reset Password")
    end
end
