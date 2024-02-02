class ClassroomStudents::EnrollStudent
  include Interactor

  REQUIRED_PARAMS = %i[student_to_update classroom].freeze

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    existing_enrollment = ClassroomStudent.find_by(classroom_id: classroom.id, student_id: student_to_update.id)

    if existing_enrollment
      context.fail!(
        error: "Enrollment failed",
        message: "Student is already enrolled in the classroom",
        status: :unprocessable_entity
      )
    else
      new_enrollment = ClassroomStudent.create(classroom_id: classroom.id, student_id: student_to_update.id)

      if new_enrollment.persisted?
        context.enrollment = new_enrollment
        context.classroom = classroom
        context.student = student_to_update
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
