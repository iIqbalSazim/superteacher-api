class Classrooms::Students::EnrollmentNotification < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[student classroom].freeze

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    ClassroomStudentMailer.with(student: student, classroom: classroom).enroll_student_email.deliver_later
  end
end
