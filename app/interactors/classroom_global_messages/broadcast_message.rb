class ClassroomGlobalMessages::BroadcastMessage
    include Interactor

    def call
        classroom_id = context.params[:classroom_id]
        message = context.new_message

        serialized_message = ClassroomGlobalMessageSerializer.new.serialize(message)

        BroadcastGlobalMessageJob.perform_now(classroom_id, serialized_message)
    end
end
