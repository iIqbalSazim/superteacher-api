class ClassroomStudents::RemoveStudent
  include Interactor
  
  REQUIRED_PARAMS = %i[student_to_update classroom].freeze

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    enrollment_to_remove = ClassroomStudent.find_by(classroom_id: classroom.id, student_id: student_to_update.id)

    if enrollment_to_remove
      if enrollment_to_remove.destroy
        context.removed_enrollment = enrollment_to_remove
        context.removed_student = student_to_update
      else
        context.fail!(
          error: "Removal failed",
          message: "Failed to remove the student from the classroom",
          status: :internal_server_error
        )
      end
    else
      context.fail!(
        error: "Removal failed",
        message: "Student is not enrolled in the classroom",
        status: :unprocessable_entity
      )
    end
  end
end
