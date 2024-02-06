class Classrooms::Students::RemoveStudent < BaseInteractor
  include Interactor
  
  REQUIRED_PARAMS = %i[student_id classroom].freeze

  STUDENT_IS_NOT_ENROLLED = "Student is not enrolled in the classroom"
  FAILED_TO_REMOVE_STUDENT = "Failed to remove the student from the classroom"

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params(REQUIRED_PARAMS)

    enrollment_to_remove = ClassroomStudent.find_by(classroom_id: classroom.id, student_id: student_id)

    handle_enrollment_result(enrollment_to_remove)
  end

  private

  def handle_enrollment_result(enrollment)
    if enrollment.present?
      remove_enrollment(enrollment)
    else
      handle_removal_failure(STUDENT_IS_NOT_ENROLLED)
    end
  end

  def remove_enrollment(enrollment)
    if enrollment.destroy
      context.removed_student = enrollment.student
    else
      handle_removal_failure(FAILED_TO_REMOVE_STUDENT)
    end
  end

  def handle_removal_failure(message)
    context.fail!(
      message: message,
      status: :unprocessable_entity
    )
  end
end
