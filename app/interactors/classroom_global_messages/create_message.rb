class ClassroomGlobalMessages::CreateMessage
    include Interactor

    REQUIRED_PARAMS = %i[params current_user].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        params[:user_id] = current_user.id

        new_message = ClassroomGlobalMessage.create(params)

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
