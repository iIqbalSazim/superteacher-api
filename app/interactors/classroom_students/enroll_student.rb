class ClassroomStudents::EnrollStudent
  include Interactor

  def call
    student_to_be_enrolled = context.student_to_update
    classroom = context.classroom

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
        context.classroom = classroom
        context.student = student_to_be_enrolled
      else
        context.fail!(
          error: "Enrollment failed",
          message: "Failed to enroll the student in the classroom",
          status: :unprocessable_entity
        )
      end
    end
  end
end
