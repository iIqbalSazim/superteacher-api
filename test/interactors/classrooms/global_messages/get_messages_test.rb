require 'test_helper'

class Classrooms::GlobalMessages::GetMessagesTest < ActiveSupport::TestCase

    def setup
        @classroom = create(:classroom)
        @user = create(:user)
    end

    test "should get messages by classroom_id" do
        message = create(:classroom_global_message, classroom: @classroom, user: @user)

        result = Classrooms::GlobalMessages::GetMessages.call(classroom_id: @classroom.id)

        assert result.success?
        assert_equal [message], result.messages
    end

    test "should return empty array if no messages" do
        result = Classrooms::GlobalMessages::GetMessages.call(classroom_id: @classroom.id)

        assert result.success?
        assert_equal [], result.messages
    end
end
