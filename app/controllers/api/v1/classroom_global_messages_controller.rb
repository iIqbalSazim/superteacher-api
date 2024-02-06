class Api::V1::ClassroomGlobalMessagesController < ApplicationController
    include Panko

    def get_messages
        result = ClassroomGlobalMessages::GetMessages.call(classroom_id: params[:classroom_id], current_user: current_user)

        if result.success?
            serialized_messages = ArraySerializer.new(result.messages, each_serializer: ClassroomGlobalMessageSerializer).to_a

            render json: { messages: serialized_messages, message: "Messages fetched successfully" }
        else
            render json: { error: result.error }, status: result.status
        end
    end

    def create_message
        result = ClassroomGlobalMessages::CreateMessageFlow.call(params: classroom_global_message_params, current_user: current_user, classroom_id: params[:classroom_id])

        if result.success?
            serialized_message = ClassroomGlobalMessageSerializer.new.serialize(result.new_message)

            render json: { new_message: serialized_message, message: "Message created successfully" }
        else
            render json: { error: result.error, message: result.message }, status: result.status
        end
    end

    private

    def classroom_global_message_params
        params.require(:classroom_global_message).permit(
            :classroom_id,
            :text,
        )
    end
end