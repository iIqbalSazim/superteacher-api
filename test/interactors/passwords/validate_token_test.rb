require 'test_helper'

class Passwords::ValidateTokenTest < ActiveSupport::TestCase

    ERROR_MSG_TOKEN_INVALID = "Token is invalid"

    test 'should validate token with valid email and token' do
        email = 'test@example.com'
        token = '12345678'

        existing_token = PasswordResetToken.new(email: email, code: token, is_used: false)

        PasswordResetToken.stubs(:find_by).with(email: email, code: token).returns(existing_token)

        result = Passwords::ValidateToken.call(email: email, token: token)

        assert result.success?
    end

    test 'should fail if token is not found' do
        email = 'test@example.com'
        token = '12345678'

        PasswordResetToken.stubs(:find_by).with(email: email, code: token).returns(nil)

        result = Passwords::ValidateToken.call(email: email, token: token)

        assert_not result.success?
    end

    test 'should fail if token is already used' do
        email = 'test@example.com'
        token = '12345678'

        existing_used_token = PasswordResetToken.new(email: email, code: token, is_used: true)

        PasswordResetToken.stubs(:find_by).with(email: email, code: token).returns(existing_used_token)

        result = Passwords::ValidateToken.call(email: email, token: token)

        assert_not result.success?
    end
end
