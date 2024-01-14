class ResourceMailer < ApplicationMailer
    def create_resource_email
        @resource = params[:resource]
        @classroom = params[:classroom]
        @student_emails = params[:student_emails]
        @teacher = params[:teacher]

        mail(to: @student_emails, subject: "Resource upload!")
    end
end
