class ClassroomStudents::FindStudent
  include Interactor

  def call
    student_id = context.params[:student_id]

    student_to_update = User.find_by(id: student_id, role: "student")

    if student_to_update
        context.student_to_update = student_to_update
    else
      context.fail!(
        error: "User not found",
        message: "Student does not exist in the database",
        status: :unprocessable_entity
      )
    end
  end
end
