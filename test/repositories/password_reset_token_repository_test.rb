require "test_helper"

class PasswordResetTokenRepositoryTest < ActiveSupport::TestCase
    test "success if the PasswordResetTokenRepository extends base_repository" do
        assert_equal BaseRepository, PasswordResetTokenRepository.superclass
    end

    test "#klass matches PasswordResetToken model" do
        assert_equal PasswordResetToken, PasswordResetTokenRepository.send(:klass)
    end

    test "find_by_email_and_code should return a token if token exists" do
        token = create(:password_reset_token)

        result = PasswordResetTokenRepository.find_by_email_and_code(token[:email], token[:code])

        assert_equal token, result
    end

    test "find_by_email_and_code should return nil if token does not exist" do

        result = PasswordResetTokenRepository.find_by_email_and_code("123@123.com", "123456")

        assert_not result.present?
    end

    test "create_token_with_email should create a token if valid params are passed" do
        params = attributes_for(:password_reset_token)

        result = PasswordResetTokenRepository.create_token_with_email(params[:email], params[:code])

        assert result.persisted?
    end
end