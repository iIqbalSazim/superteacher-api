require 'test_helper'

class Passwords::ResetPasswordTest < ActiveSupport::TestCase

    ERROR_MSG_INVALID = Passwords::Reset::INVALID
    ERROR_MSG_SOMETHING_WENT_WRONG = BaseInteractor::SOMETHING_WENT_WRONG


    def setup
        @user = users(:math_teacher)
    end

    test 'should reset password with valid parameters' do
        params = {
            email: @user["email"],
            old_password: "password",
            new_password: "Password1"
        }

        params = params.stringify_keys

        User.any_instance.stubs(:authenticate).returns(true)

        result = Passwords::Reset.call(params: params, current_user: @user)

        assert result.success?
        assert_not_equal params["old_password"], User.find(@user.id)[:password]
    end

    test 'should fail if old password is incorrect' do
        params = {
            email: @user["email"],
            old_password: "incorrect_password",
            new_password: "Password1"
        }

        params = params.stringify_keys

        User.any_instance.stubs(:authenticate).returns(false)

        result = Passwords::Reset.call(params: params, current_user: @user)

        assert_not result.success?
        assert_equal ERROR_MSG_INVALID, result.message
        assert_equal :unprocessable_entity, result.status
    end

    test 'should fail if something goes wrong during password update' do
        params = {
            email: @user["email"],
            old_password: "password",
            new_password: "Password1"
        }

        params = params.stringify_keys

        User.any_instance.stubs(:authenticate).returns(true)
        User.any_instance.stubs(:update).returns(false)

        result = Passwords::Reset.call(params: params, current_user: @user)

        assert_not result.success?
        assert_equal ERROR_MSG_SOMETHING_WENT_WRONG, result.message
    end
end
