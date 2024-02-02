class ResourceMailer < ApplicationMailer
    def create_resource_email
        @resource = params[:resource]
        @classroom = params[:classroom]
        @student_email = params[:student_email]
        @teacher = params[:teacher]

        mail(to: @student_email, subject: "Resource upload!")
    end
end
