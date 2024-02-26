class Classrooms::Exams::MailEnrolledStudents < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[exam classroom].freeze

    delegate(*REQUIRED_PARAMS, to: :context)
  
    def call
        validate_params REQUIRED_PARAMS

        classroom.students.each do |student|
            ExamMailer.with(exam: exam, student_email: student.email, classroom: classroom).create_exam_email.deliver_later
        end
    end
end