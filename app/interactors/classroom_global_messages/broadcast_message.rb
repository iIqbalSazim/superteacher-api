class ClassroomGlobalMessages::BroadcastMessage
    include Interactor

    def call
        classroom_id = context.params[:classroom_id]
        message = context.new_message

        serialized_message = ClassroomGlobalMessageSerializer.new.serialize(message)

        ActionCable.server.broadcast "classroom_#{classroom_id}_global_chat", serialized_message
    end
end
