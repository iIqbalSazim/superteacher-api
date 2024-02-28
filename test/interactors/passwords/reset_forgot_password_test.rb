require "test_helper"

class Passwords::ResetForgotPasswordTest < ActiveSupport::TestCase

    ERROR_MSG_USER_NOT_FOUND_ERROR = Passwords::ResetForgotPassword::USER_NOT_FOUND_ERROR
    ERROR_MSG_FAILED_UPDATE_ERROR = Passwords::ResetForgotPassword::FAILED_UPDATE_ERROR
    ERROR_MSG_INVALID_CODE_ERROR = Passwords::ResetForgotPassword::INVALID_CODE_ERROR

    def setup
        @user = users(:math_teacher)
    end

    test "should reset password with valid parameters" do
        email = @user[:email]
        new_password = "new_password"
        token = "12345678"

        params = {
            email: email,
            new_password: new_password
        }   

        params = params.stringify_keys

        existing_token = PasswordResetToken.new(email: email, code: token, is_used: false)

        PasswordResetToken.stubs(:find_by).with(email: email, code: token).returns(existing_token)
        @user.stubs(:update).with(password: new_password).returns(true)
        existing_token.stubs(:update).with(is_used: true).returns(true)

        result = Passwords::ResetForgotPassword.call(params: params, token: token)

        assert result.success?
    end

    test "should fail if user is not found" do
        email = @user[:email]
        new_password = "new_password"
        token = "12345678"

        params = {
            email: email,
            new_password: new_password
        }   

        params = params.stringify_keys

        User.stubs(:find_by).with(email: email).returns(nil)

        result = Passwords::ResetForgotPassword.call(params: params, token: token)

        assert ERROR_MSG_USER_NOT_FOUND_ERROR, result.message
    end

    test "should throw error if code is already used" do
        email = @user[:email]
        new_password = "new_password"
        token = "12345678"

        params = {
            email: email,
            new_password: new_password
        }   

        params = params.stringify_keys

        already_used_token = PasswordResetToken.new(email: email, code: token, is_used: true)

        PasswordResetToken.stubs(:find_by).with(email: email, code: token).returns(already_used_token)

        result = Passwords::ResetForgotPassword.call(params: params, token: token)

        assert ERROR_MSG_INVALID_CODE_ERROR, result.message
    end

    test "should throw error if code does not exist" do
        email = @user[:email]
        new_password = "new_password"
        token = "12345678"

        params = {
            email: email,
            new_password: new_password
        }   

        params = params.stringify_keys

        PasswordResetToken.stubs(:find_by).with(email: email, code: token).returns(nil)

        result = Passwords::ResetForgotPassword.call(params: params, token: token)

        assert ERROR_MSG_INVALID_CODE_ERROR, result.message
    end

    test "should throw error if password update fails" do
        email = @user[:email]
        new_password = "new_password"
        token = "12345678"

        params = {
            email: email,
            new_password: new_password
        }   

        params = params.stringify_keys

        existing_token = PasswordResetToken.new(email: email, code: token, is_used: false)

        PasswordResetToken.stubs(:find_by).with(email: email, code: token).returns(existing_token)

        User.any_instance.stubs(:update).with(password: new_password).returns(false)

        result = Passwords::ResetForgotPassword.call(params: params, token: token)

        assert ERROR_MSG_FAILED_UPDATE_ERROR, result.message
    end
end
