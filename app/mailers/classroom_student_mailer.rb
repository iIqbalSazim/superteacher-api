class ClassroomStudentMailer < ApplicationMailer
    def enroll_student_email
        @student = params[:student]
        @classroom = params[:classroom]

        mail(to: "ishmam.iqbal@sazim.io", subject: "Enrollment update!")
    end
end
