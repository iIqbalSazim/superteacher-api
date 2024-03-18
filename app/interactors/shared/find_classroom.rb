class Shared::FindClassroom < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[classroom_id].freeze

  CLASSROOM_NOT_FOUND = "Classroom not found"

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    classroom = ClassroomRepository.find_by_id(classroom_id)

    handle_classroom_result(classroom)
  end

  private

  def handle_classroom_result(classroom)
    if classroom.present?
      context.classroom = classroom
    else
      handle_classroom_not_found
    end
  end

  def handle_classroom_not_found
    context.fail!(
      message: CLASSROOM_NOT_FOUND, 
    )
  end
end
