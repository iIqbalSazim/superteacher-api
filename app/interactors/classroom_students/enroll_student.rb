class ClassroomStudents::EnrollStudent
  include Interactor

  REQUIRED_PARAMS = %i[student_id classroom].freeze

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    if classroom.student_ids.include?(student_id)
      context.fail!(
        error: "Enrollment failed",
        message: "Student is already enrolled in the classroom",
        status: :unprocessable_entity
      )
    else
      new_enrollment = ClassroomStudent.create(classroom_id: classroom.id, student_id: student_id)

      if new_enrollment.persisted?
        context.student = new_enrollment.student
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
