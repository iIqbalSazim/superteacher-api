require 'test_helper'

class Api::V1::PasswordsControllerTest < ActionController::TestCase
    setup :setup_controller_with_fake_user

    test "#reset responds with success" do
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
end