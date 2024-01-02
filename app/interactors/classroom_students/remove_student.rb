class ClassroomStudents::RemoveStudent
  include Interactor

  def call
    classroom_id = context.params[:classroom_id]
    student_id = context.params[:student_id]

    student_to_be_removed = User.find_by(id: student_id)

    if student_to_be_removed
      classroom = Classroom.find_by(id: classroom_id)

      if classroom
        enrollment_to_remove = ClassroomStudent.find_by(classroom_id: classroom.id, student_id: student_to_be_removed.id)

        if enrollment_to_remove
          if enrollment_to_remove.destroy
            context.enrollment = enrollment_to_remove
            context.student = student_to_be_removed
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
      else
        context.fail!(
          error: "Removal failed",
          message: "Classroom does not exist in the database",
          status: :unprocessable_entity
        )
      end
    else
      context.fail!(
        error: "Removal failed",
        message: "Student does not exist in the database",
        status: :unprocessable_entity
      )
    end
  end
end
