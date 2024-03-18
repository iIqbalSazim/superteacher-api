require 'test_helper'

class Passwords::ValidateTokenTest < ActiveSupport::TestCase

    ERROR_MSG_TOKEN_INVALID = "Token is invalid"

    test 'should validate token with valid email and token' do
        existing_token = create(:password_reset_token)

        result = Passwords::ValidateToken.call(email: existing_token.email, token: existing_token.code)

        assert result.success?
    end

    test 'should fail if token is not found' do
        email = 'test@example.com'
        token = '12345678'

        token_mock = mock
        token_mock.expects(:present?).returns(false)

        PasswordResetTokenRepository.expects(:find_by_email_and_code)
                                    .with(email, token)
                                    .returns(token_mock)

        result = Passwords::ValidateToken.call(email: email, token: token)

        assert_not result.success?
    end

    test 'should fail if token is already used' do
        existing_used_token = create(:password_reset_token, :used)

        result = Passwords::ValidateToken.call(email: existing_used_token.email, token: existing_used_token.code)

        assert_not result.success?
    end
end
