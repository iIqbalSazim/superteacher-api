class Shared::ValidateClassroomTeacher < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[current_user classroom].freeze

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    context.fail!(
      message: UNAUTHORIZED, 
      status: :forbidden
    ) unless classroom.teacher_id == current_user.id
  end
end