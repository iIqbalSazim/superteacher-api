require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase

    test "#create responds with success" do
        params = { user: { email: "test@email.com" } }

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:user_data).returns({})

        serializer_mock = mock
        serializer_mock.expects(:serialize).returns({})

        UserSerializer.expects(:new).returns(serializer_mock)

        Users::UserRegistrationFlow.expects(:call).returns(interactor_result)

        post :create, params: params

        assert_response :ok
    end

    test "#create does not respond with success" do
        params = { user: { email: "test@email.com" } }

        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:message).returns("some error")
        interactor_result.expects(:status).returns(:unprocessable_entity)
        interactor_result.expects(:attempts_remaining).returns({})

        Users::UserRegistrationFlow.expects(:call).returns(interactor_result)

        post :create, params: params

        assert_response :unprocessable_entity
    end
end