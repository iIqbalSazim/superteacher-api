class ClassroomStudents::EnrollStudent
  include Interactor

  def call
    classroom_id = context.params[:classroom_id]
    student_id = context.params[:student_id]

    enrolled_student = User.find_by(id: student_id)

    if enrolled_student
      classroom = Classroom.find_by(id: classroom_id)

      if classroom
        new_enrollment = ClassroomStudent.create(classroom_id: classroom.id, student_id: enrolled_student.id)

        if new_enrollment.persisted?
          context.enrollment = new_enrollment
          context.student = enrolled_student
        else
          context.fail!(
            error: "Enrollment failed",
            message: "Failed to enroll the student in the classroom",
            status: :unprocessable_entity
          )
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
