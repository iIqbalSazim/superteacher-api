class Classrooms::Students::EnrollStudent < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[student_id classroom].freeze

  FAILED_TO_ENROLL_STUDENT = "Failed to enroll the student in the classroom"
  STUDENT_ALREADY_ENROLLED = "Student is already enrolled in the classroom"

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    if student_already_enrolled?
      handle_enrollment_failure(STUDENT_ALREADY_ENROLLED)
    else
      enroll_student
    end
  end

  private

  def student_already_enrolled?
    classroom.student_ids.include?(student_id)
  end

  def enroll_student
    new_enrollment = ClassroomStudent.create(classroom_id: classroom.id, student_id: student_id)

    if new_enrollment.persisted?
      context.student = new_enrollment.student
    else
      handle_enrollment_failure(FAILED_TO_ENROLL_STUDENT)
    end
  end

  def handle_enrollment_failure(message)
    context.fail!(
      message: message,
      status: :unprocessable_entity
    )
  end
end
