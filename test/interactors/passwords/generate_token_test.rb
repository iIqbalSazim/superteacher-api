require 'test_helper'

class Passwords::GenerateTokenTest < ActiveSupport::TestCase

    test 'should generate token and mail user with valid email' do
        student_user = create(:user, :student)

        email = student_user.email
        code = "a1b2c3d4"

        SecureRandom.expects(:random_number).returns(code)
        
        token_mock = mock
        token_mock.expects(:persisted?).returns(true)
        token_mock.expects(:code).returns(code)

        PasswordResetTokenRepository.expects(:create_token_with_email)
                                    .with(email, code)
                                    .returns(token_mock)

        mailer = mock
        mailer.expects(:password_token_email).returns(mock(deliver_later: true))
        PasswordMailer.expects(:with).with(email: email, token: code).returns(mailer) 

        result = Passwords::GenerateToken.call(email: email)

        assert result.success?
    end

    test 'should do nothing if user with email does not exist' do
        email = 'nonexistent@user.com'

        user_mock = mock
        user_mock.expects(:present?).returns(false)

        User.expects(:find_by).with(email: email).returns(user_mock)

        result = Passwords::GenerateToken.call(email: email)

        assert result.success?
    end
end
