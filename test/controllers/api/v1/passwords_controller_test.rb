require 'test_helper'

class Api::V1::PasswordsControllerTest < ActionController::TestCase

    SUCCESS_MSG_PASSWORD_RESET_SUCCESSFUL = Api::V1::PasswordsController::PASSWORD_RESET_SUCCESSFUL
    ERROR_MSG_INVALID_CODE = Api::V1::PasswordsController::INVALID_CODE

    test "#reset responds with success" do
        setup_controller_with_fake_user

        existing_user = @fake_user

        params = {
            password: {
                email: @fake_user["email"],
                new_password: "Password2",
                old_password: "password"
            }
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)

        Passwords::Reset.expects(:call).returns(interactor_result)

        put :reset, params: params

        assert_response :ok
    end

    test "#reset does not respond with success" do
        setup_controller_with_fake_user

        existing_user = @fake_user

        params = {
            password: {
                email: @fake_user["email"],
                new_password: "Password2",
                old_password: "password"
            }
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:message).returns("some error")

        Passwords::Reset.expects(:call).returns(interactor_result)

        put :reset, params: params

        assert_response :unprocessable_entity
    end

    test "#token responds with success" do
        params = {
            email: "test@email.com"
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)

        Passwords::GenerateToken.expects(:call).returns(interactor_result)

        post :token, params: params

        assert_response :ok
    end

    test "#token does not respond with success" do
        params = {
            email: "test@email.com"
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(false)

        Passwords::GenerateToken.expects(:call).returns(interactor_result)

        post :token, params: params

        assert_response :no_content
    end

    test "#validate responds with success" do
        params = {
            email: "test@email.com",
            token: "123456"
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)

        Passwords::ValidateToken.expects(:call).returns(interactor_result)

        post :validate, params: params

        assert_response :ok
    end

    test "#validate does not respond with success" do
        params = {
            email: "test@email.com",
            token: "123456"
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(false)

        Passwords::ValidateToken.expects(:call).returns(interactor_result)

        post :validate, params: params

        assert_response :unprocessable_entity
        assert_equal ERROR_MSG_INVALID_CODE, JSON.parse(response.body)["message"]
    end

    test "reset_forgot responds with success" do
        params = {
            token: "123456",
            password: {
                new_password: "Password1",
                old_password: "password",
                email: "test@email.com"
            }
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)

        Passwords::ResetForgotPassword.expects(:call).returns(interactor_result)

        put :reset_forgot, params: params

        assert_response :ok
        assert_equal SUCCESS_MSG_PASSWORD_RESET_SUCCESSFUL, JSON.parse(response.body)["message"]
    end

    test "reset_forgot does not respond with success" do
        params = {
            token: "123456",
            password: {
                new_password: "Password1",
                old_password: "password",
                email: "test@email.com"
            }
        }

        ERROR_MSG = "some error message"

        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:message).returns(ERROR_MSG)

        Passwords::ResetForgotPassword.expects(:call).returns(interactor_result)

        put :reset_forgot, params: params

        assert_response :unprocessable_entity
        assert_equal ERROR_MSG, JSON.parse(response.body)["message"]
    end
end