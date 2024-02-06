class ClassroomStudents::RemoveStudent
  include Interactor
  
  REQUIRED_PARAMS = %i[student_id classroom].freeze

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    enrollment_to_remove = ClassroomStudent.find_by(classroom_id: classroom.id, student_id: student_id)

    if enrollment_to_remove
      if enrollment_to_remove.destroy
        context.removed_student = enrollment_to_remove.student
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
