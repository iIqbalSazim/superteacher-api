class ClassroomStudents::EnrollStudent
  include Interactor

  def call
    classroom_id = context.params[:classroom_id]
    student_id = context.params[:student_id]

    student_to_be_enrolled = User.find_by(id: student_id)

    if student_to_be_enrolled
      classroom = Classroom.find_by(id: classroom_id)

      if classroom
        existing_enrollment = ClassroomStudent.find_by(classroom_id: classroom.id, student_id: student_to_be_enrolled.id)

        if existing_enrollment
          context.fail!(
            error: "Enrollment failed",
            message: "Student is already enrolled in the classroom",
            status: :unprocessable_entity
          )
        else
          new_enrollment = ClassroomStudent.create(classroom_id: classroom.id, student_id: student_to_be_enrolled.id)

          if new_enrollment.persisted?
            context.enrollment = new_enrollment
            context.student = student_to_be_enrolled
          else
            context.fail!(
              error: "Enrollment failed",
              message: "Failed to enroll the student in the classroom",
              status: :unprocessable_entity
            )
          end
        end
      else
        context.fail!(
          error: "Enrollment failed",
          message: "Classroom does not exist in the database",
          status: :unprocessable_entity
        )
      end
    else
      context.fail!(
        error: "Enrollment failed",
        message: "Student does not exist in the database",
        status: :unprocessable_entity
      )
    end
  end
end
