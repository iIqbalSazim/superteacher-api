require 'test_helper'

class Api::V1::Classrooms::GlobalMessagesControllerTest < ActionController::TestCase
    setup :setup_controller_with_fake_user

    def setup
        @message_params = {
            classroom_id: 1,
            global_message: {
                user_id: 1,
                classroom_id: 1,
                message: "test_message"
            }
        }
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

    test "#create responds with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:new_message).returns({})

        serializer_mock = mock
        serializer_mock.expects(:serialize).returns({})

        GlobalMessageSerializer.expects(:new).returns(serializer_mock)

        Classrooms::GlobalMessages::CreateMessageFlow.expects(:call).returns(interactor_result)

        post :create, params: @message_params

        assert_response :ok
    end

    test "#create does not respond with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:message).returns("some error")
        interactor_result.expects(:status).returns(:unprocessable_entity)
        
        Classrooms::GlobalMessages::CreateMessageFlow.expects(:call).returns(interactor_result)

        post :create, params: @message_params

        assert_response :unprocessable_entity
    end
end
