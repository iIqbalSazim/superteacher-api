require 'test_helper'

class Passwords::GenerateTokenTest < ActiveSupport::TestCase

    test 'should generate token and mail user with valid email' do
        student_user = users(:math_student)

        email = "test@email.com"
        
        User.stubs(:find_by).with(email: email).returns(student_user)

        PasswordResetToken.any_instance.stubs(:persisted?).returns(true)
        PasswordResetToken.any_instance.stubs(:code).returns('12345678')

        mailer = mock
        mailer.expects(:password_token_email).returns(mock(deliver_later: true))
        PasswordMailer.expects(:with).with(email: email, token: '12345678').returns(mailer) 

        result = Passwords::GenerateToken.call(email: email)

        assert result.success?
    end

    test 'should do nothing if user with email does not exist' do
        email = 'nonexistent@example.com'

        User.stubs(:find_by).with(email: email).returns(nil)

        PasswordResetToken.expects(:create).never

        result = Passwords::GenerateToken.call(email: email)

        assert result.success?
    end
end
