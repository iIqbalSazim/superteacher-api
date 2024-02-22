require 'test_helper'

class Classrooms::GlobalMessages::CreateMessageTest < ActiveSupport::TestCase
    def setup
        @params = {
            user_id: users(:teacher_user).id,
            classroom_id: classrooms(:classroom_one).id,
            text: "Test message"
        }
    end

    test "should create a new message with valid parameters" do
        interactor_result = Classrooms::GlobalMessages::CreateMessage.call(params: @params)

        assert interactor_result.success?
        assert_not_nil interactor_result.new_message
        assert interactor_result.new_message.persisted?
    end

    test "should fail to create message with invalid parameters" do
        invalid_params = { user_id: nil, classroom_id: nil, text: nil }

        interactor_result = Classrooms::GlobalMessages::CreateMessage.call(params: invalid_params)

        assert_not interactor_result.success?
        assert_nil interactor_result.new_message
        assert_equal interactor_result.message, "Failed to create message"
        assert_equal interactor_result.status, :unprocessable_entity
    end
end
