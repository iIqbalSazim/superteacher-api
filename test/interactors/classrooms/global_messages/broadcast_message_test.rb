require 'test_helper'

class Classrooms::GlobalMessages::BroadcastMessageTest < ActiveSupport::TestCase

    test "should broadcast message successfully" do
        classroom = classrooms(:math_classroom)
        message = classroom_global_messages(:message_one)

        result = Classrooms::GlobalMessages::BroadcastMessage.call(
            classroom_id: classroom.id,
            new_message: message
        )

        assert result.success?
    end

    test "should fail to broadcast message without required parameters" do
        result = Classrooms::GlobalMessages::BroadcastMessage.call(
            classroom_id: 1,
            new_message: nil
        )

        assert_not result.success?
    end
end
