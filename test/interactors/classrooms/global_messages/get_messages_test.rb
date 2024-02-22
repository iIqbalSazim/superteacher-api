require 'test_helper'

class Classrooms::GlobalMessages::GetMessagesTest < ActiveSupport::TestCase

    test "should get messages by classroom_id" do
        classroom_id = classrooms(:math_classroom).id

        message = classroom_global_messages(:message_one)

        result = Classrooms::GlobalMessages::GetMessages.call(classroom_id: classroom_id)

        assert result.success?
        assert_equal [message], result.messages
    end

    test "should return empty array if no messages" do
        classroom_id = classrooms(:empty_classroom).id

        result = Classrooms::GlobalMessages::GetMessages.call(classroom_id: classroom_id)

        assert result.success?
        assert_equal [], result.messages
    end
end
