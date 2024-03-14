require 'test_helper'

class Users::ValidateRegistrationCodeTest < ActiveSupport::TestCase

    ERROR_MSG_VALIDATION_ATTEMPTS_EXCEEDED = Users::ValidateRegistrationCode::VALIDATION_ATTEMPTS_EXCEEDED 
    ERROR_MSG_INVALID_CODE = Users::ValidateRegistrationCode::INVALID_CODE  

    def setup
        @registration_code = create(:registration_code)
        @user_params = {
            email: @registration_code.email,
            role: "teacher",
            code: @registration_code.code
        }
    end

    test "validates registration code when correct params are passed" do
        result = Users::ValidateRegistrationCode.call(user_params: @user_params)

        @registration_code.reload

        assert result.success?
        assert_equal @registration_code.code, result.code
        assert @registration_code.is_used
        assert_equal 0, @registration_code.attempts_count
    end

    test "returns error and decrements attempts_count if registration code is wrong" do
        user_params = @user_params.dup.merge!(code: "!valid")

        result = Users::ValidateRegistrationCode.call(user_params: user_params)

        assert_not result.success?
        assert_equal ERROR_MSG_INVALID_CODE, result.message
        assert_equal 2, @registration_code.reload.attempts_count
    end

    test "returns error if wrong email" do
        user_params = @user_params.merge(email: "invalid@email.com")

        result = Users::ValidateRegistrationCode.call(user_params: user_params)

        assert_not result.success?
        assert_equal ERROR_MSG_INVALID_CODE, result.message
    end

    test "returns error if registration code attempts are exceeded" do
        attempts_exceeded_code = create(:registration_code, :attempts_count_zero)

        user_params = {
            email: attempts_exceeded_code.email,
            role: "teacher",
            code: attempts_exceeded_code.code
        }

        result = Users::ValidateRegistrationCode.call(user_params: user_params)

        assert_not result.success?
        assert_equal ERROR_MSG_VALIDATION_ATTEMPTS_EXCEEDED, result.message
    end

    test "returns if user role is student" do
        user_params = @user_params.merge(role: "student")

        result = Users::ValidateRegistrationCode.call(user_params: user_params)

        assert result.success?
        assert_nil result.code
    end
end
