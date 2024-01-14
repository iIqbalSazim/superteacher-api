class Resources::FindTeacher
  include Interactor

  def call
    classroom_id = context.classroom_id

    teacher_id = Classroom.where(id: classroom_id).pluck(:teacher_id)

    teacher = User.find_by(id: teacher_id)

    if teacher
        context.teacher = teacher
        context.teacher_id = teacher_id
    else
        context.fail!(
          error: "User not found",
          message: "Teacher does not exist in the database",
          status: :unprocessable_entity
        )
    end
  end
end
