class BroadcastGlobalMessageJob < ApplicationJob
  queue_as :default

  def perform(classroom_id, serialized_message)
    ActionCable.server.broadcast "classroom_#{classroom_id}_global_chat", serialized_message
  end
end
