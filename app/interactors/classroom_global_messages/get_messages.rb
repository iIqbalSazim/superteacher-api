class ClassroomGlobalMessages::GetMessages
    include Interactor

    REQUIRED_PARAMS = %i[current_user classroom_id].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        all_messages = ClassroomGlobalMessage.where(classroom_id: classroom_id)

        if all_messages.present?
            context.messages = all_messages
        else
            context.fail!(
                error: "No messages found",
            )
        end
    end

end
