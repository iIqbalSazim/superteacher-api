class ClassroomGlobalMessages::CreateMessage
    include Interactor

    def call
        classroom_global_message_params = context.params
        current_user = context.current_user

        classroom_global_message_params[:user_id] = current_user.id

        new_message = ClassroomGlobalMessage.create(classroom_global_message_params)

        if new_message.persisted?
            context.new_message = new_message
        else
            context.fail!(
                error: "Message creation failed",
                message: "Failed to create message",
                status: :unprocessable_entity,
            )
        end
    end
end
