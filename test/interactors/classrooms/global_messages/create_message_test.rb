require 'test_helper'

class Classrooms::GlobalMessages::CreateMessageTest < ActiveSupport::TestCase

    ERROR_MSG_FAILED_TO_CREATE_MESSAGE = Classrooms::GlobalMessages::CreateMessage::FAILED_TO_CREATE_MESSAGE

    test "should create a new message with valid parameters" do
        valid_params = attributes_for(:classroom_global_message,
                                      user_id: create(:user, :teacher).id,
                                      classroom_id: create(:classroom).id)

        result = Classrooms::GlobalMessages::CreateMessage.call(params: valid_params)

        assert result.success?
        assert_not_nil result.new_message
        assert result.new_message.persisted?
    end

    test "should fail to create message with invalid parameters" do
        invalid_params = {
            text: nil
        }

        result = Classrooms::GlobalMessages::CreateMessage.call(params: invalid_params)

        assert_not result.success?
        assert_equal ERROR_MSG_FAILED_TO_CREATE_MESSAGE, result.message
        assert_equal result.status, :unprocessable_entity
    end

    test "should fail with an error if fails to create message" do
        valid_params = attributes_for(:classroom_global_message,
                                      user: create(:user, :teacher),
                                      classroom: create(:classroom))

        ClassroomGlobalMessage.any_instance.stubs(:persisted?).returns(false)

        result = Classrooms::GlobalMessages::CreateMessage.call(params: valid_params)

        assert_not result.success?
        assert_equal ERROR_MSG_FAILED_TO_CREATE_MESSAGE, result.message
        assert_equal result.status, :unprocessable_entity
    end
end
