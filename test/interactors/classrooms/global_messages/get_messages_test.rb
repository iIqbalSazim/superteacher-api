require 'test_helper'

class Classrooms::GlobalMessages::GetMessagesTest < ActiveSupport::TestCase
    def setup
        @classroom_id = 1
        @message = classroom_global_messages(:message_one)
    end

    test "get messages by classroom_id" do
        result = Classrooms::GlobalMessages::GetMessages.call(classroom_id: @classroom_id)

        assert result.success?
        assert_equal [@message], result.messages
    end
end
