class ExamMailer < ApplicationMailer
    def create_exam_email
        @exam = params[:exam]
        @classroom = params[:classroom]
        @student_email = params[:student_email]
        @teacher = params[:teacher]

        mail(to: @student_email, subject: "Exam scheduled!")
    end
end
