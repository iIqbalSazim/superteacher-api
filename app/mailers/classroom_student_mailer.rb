class ClassroomStudentMailer < ApplicationMailer
    def enroll_student_email
        @student = params[:student]
        @classroom = params[:classroom]

        mail(to: @student[:email], subject: "Enrollment update!")
    end
end
