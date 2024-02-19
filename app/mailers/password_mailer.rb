class PasswordMailer < ApplicationMailer
    def forgot_password_email
        @email = params[:email]
        @new_password = params[:new_password]

        mail(to: @email, subject: "Reset Password")
    end
end
