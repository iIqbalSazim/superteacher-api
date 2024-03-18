class Classrooms::GlobalMessages::CreateMessage < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[params].freeze

    FAILED_TO_CREATE_MESSAGE = "Failed to create message"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        new_message = ClassroomGlobalMessageRepository.create(params)

        handle_message_creation_result(new_message)
    end

    private

    def handle_message_creation_result(new_message)
        if new_message.persisted?
            context.new_message = new_message
        else
            context.fail!(
                message: FAILED_TO_CREATE_MESSAGE,
                status: :unprocessable_entity
            )
        end
    end
end
