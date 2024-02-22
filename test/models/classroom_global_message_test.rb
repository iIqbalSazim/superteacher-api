require 'test_helper'

class ClassroomGlobalMessageTest < ActiveSupport::TestCase
    should belong_to(:classroom)
    should belong_to(:user)

    should validate_presence_of(:text)
    should validate_length_of(:text).is_at_most(10000)
    should validate_presence_of(:user_id)
    should validate_presence_of(:classroom_id)

    test "message is created with validations passing" do
        classroom = classrooms(:classroom_one)
        user = users(:teacher_user)
        valid_message = ClassroomGlobalMessage.new(
            text: "Valid message text",
            classroom_id: classroom.id,
            user_id: user.id
        )

        assert valid_message.valid?
        assert_empty valid_message.errors
    end

    test "message fails to create with validations failing" do
        invalid_message = ClassroomGlobalMessage.new

        assert_not invalid_message.valid?
        assert_not_empty invalid_message.errors[:text]
        assert_not_empty invalid_message.errors[:classroom_id]
        assert_not_empty invalid_message.errors[:user_id]
    end
end
