require 'test_helper'

class Api::V1::Classrooms::GlobalMessagesControllerTest < ActionController::TestCase
    setup :setup_controller_with_fake_user

    def setup
        @user = users(:teacher_user)
        @classroom = classrooms(:classroom_one)
    end

    test "#index responds with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:messages).returns([])

        Classrooms::GlobalMessages::GetMessagesFlow.expects(:call).returns(interactor_result)

        get :index, params: { classroom_id: 1 }

        assert_response :ok
    end

    test "#index does not respond with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:message).returns("some error message")

        Classrooms::GlobalMessages::GetMessagesFlow.expects(:call).returns(interactor_result)

        get :index, params: { classroom_id: 1 }

        assert_response :unprocessable_entity
    end
end
