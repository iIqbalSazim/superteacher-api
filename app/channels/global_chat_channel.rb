class GlobalChatChannel < ApplicationCable::Channel
    def subscribed
        stream_id = params[:classroom_id]
        if stream_id
            stream_from "classroom_#{stream_id}_global_chat"  
        else
            reject
        end
    end

    def unsubscribed
        # Any cleanup needed when channel is unsubscribed
    end
end