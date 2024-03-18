require 'test_helper'

class Passwords::ResetPasswordTest < ActiveSupport::TestCase

    ERROR_MSG_INVALID = Passwords::Reset::INVALID
    ERROR_MSG_SOMETHING_WENT_WRONG = BaseInteractor::SOMETHING_WENT_WRONG


    def setup
        @user = create(:user)
    end

    test 'should reset password with valid parameters' do
        params = {
            email: @user.email,
            old_password: "password",
            new_password: "Password1"
        }

        params = params.stringify_keys

        result = Passwords::Reset.call(params: params, current_user: @user)

        assert result.success?
        assert_not_equal params["old_password"], User.find(@user.id)[:password]
    end

    test 'should fail if old password is incorrect' do
        params = {
            email: @user.email,
            old_password: "incorrect_password",
            new_password: "Password1"
        }

        params = params.stringify_keys

        result = Passwords::Reset.call(params: params, current_user: @user)

        assert_not result.success?
        assert_equal ERROR_MSG_INVALID, result.message
        assert_equal :unprocessable_entity, result.status
    end

    test 'should fail if user fails to update' do
        params = {
            email: @user.email,
            old_password: "password",
            new_password: "Password1"
        }

        params = params.stringify_keys

        user_mock = mock
        user_mock.expects(:valid?).returns(false)

        UserRepository.expects(:update)
                      .with(@user, { password: params["new_password"] })
                      .returns(user_mock)

        result = Passwords::Reset.call(params: params, current_user: @user)

        assert_not result.success?
        assert_equal ERROR_MSG_SOMETHING_WENT_WRONG, result.message
    end
end
