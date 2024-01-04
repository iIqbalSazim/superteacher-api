class ClassroomGlobalMessages::GetMessages
    include Interactor

    def call
        classroom_id = context.classroom_id
        current_user = context.current_user

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
