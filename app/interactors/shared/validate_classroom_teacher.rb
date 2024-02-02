class Shared::ValidateClassroomTeacher
  include Interactor

  REQUIRED_PARAMS = %i[current_user classroom].freeze

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    if classroom.teacher_id != current_user.id
      context.fail!(
        error: "Unauthorized",
        message: "You are not authorized",
        status: :forbidden
      )
    end
  end
end
