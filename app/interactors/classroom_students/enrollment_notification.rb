class ClassroomStudents::EnrollmentNotification
  include Interactor

  REQUIRED_PARAMS = %i[student classroom].freeze

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    if student && classroom
      ClassroomStudentMailer.with(student: student, classroom: classroom).enroll_student_email.deliver_later
    end
  end
end
