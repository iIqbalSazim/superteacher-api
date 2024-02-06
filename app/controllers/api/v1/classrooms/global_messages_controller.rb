class Api::V1::Classrooms::GlobalMessagesController < BaseController

    def index
        result = Classrooms::GlobalMessages::GetMessagesFlow.call(classroom_id: params[:classroom_id],
                                                                  current_user: current_user)

        if result.success?
            serialized_messages = ArraySerializer.new(result.messages, each_serializer: GlobalMessageSerializer).to_a

            render json: { messages: serialized_messages }, status: :ok
        else
            render json: { message: result.message }, status: :unprocessable_entity
        end
    end

    def create
        result = Classrooms::GlobalMessages::CreateMessageFlow.call(params: global_message_params,
                                                                    current_user: current_user,
                                                                    classroom_id: params[:classroom_id])

        if result.success?
            serialized_message = GlobalMessageSerializer.new.serialize(result.new_message)

            render json: { new_message: serialized_message }, status: :ok
        else
            render json: { message: result.message }, status: result.status
        end
    end

    private

    def global_message_params
        params.require(:global_message).permit(
            :user_id,
            :classroom_id,
            :text,
        )
    end

    def resource_model
        [:classrooms, :global_message]
    end
end