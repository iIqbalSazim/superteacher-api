class Shared::ValidateClassroomTeacher
  include Interactor

  def call
    classroom = context.classroom
    current_user = context.current_user

    if classroom.teacher_id != current_user.id
      context.fail!(
        error: "Unauthorized",
        message: "You are not authorized",
        status: :forbidden
      )
    end
  end
end
