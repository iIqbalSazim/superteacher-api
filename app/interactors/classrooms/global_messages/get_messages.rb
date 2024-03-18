class Classrooms::GlobalMessages::GetMessages < BaseInteractor
  include Interactor

  REQUIRED_PARAMS = %i[classroom_id].freeze

  delegate(*REQUIRED_PARAMS, to: :context)

  def call
    validate_params REQUIRED_PARAMS

    all_messages = ClassroomGlobalMessageRepository.find_by_classroom_id(classroom_id)

    context.messages = all_messages
  end
end
