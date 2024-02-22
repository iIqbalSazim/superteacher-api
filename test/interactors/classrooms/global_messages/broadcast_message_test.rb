require 'test_helper'

class Classrooms::GlobalMessages::BroadcastMessageTest < ActiveSupport::TestCase
    def setup
        @classroom = classrooms(:classroom_one)
        @message = classroom_global_messages(:message_one)
    end

    test "should broadcast message successfully" do
        result = Classrooms::GlobalMessages::BroadcastMessage.call(classroom_id: @classroom.id, new_message: @message)

        assert result.success?
    end

    test "should fail to broadcast message without required parameters" do
        result = Classrooms::GlobalMessages::BroadcastMessage.call(classroom_id: nil, new_message: nil)

        assert_not result.success?
    end
end
