require 'test_helper'

class Users::ValidateRegistrationCodeTest < ActiveSupport::TestCase
    def setup
        @user_params = { email: "test@email.com", role: "teacher", code: "valid1" }
    end

  test "validates registration code when correct params are passed" do
    registration_code = registration_codes(:valid_code)

    result = Users::ValidateRegistrationCode.call(user_params: @user_params)

    assert result.success?
    assert_equal registration_code.code, result.code
    assert registration_code.reload.is_used
    assert_equal 0, registration_code.attempts_count
  end

    test "returns error if registration code is invalid" do
        result = Users::ValidateRegistrationCode.call(user_params: @user_params.merge(code: "invalid_code"))

        assert_not result.success?
        assert_equal "Invalid registration code. Please try again or contact the admin.", result.message
    end

    test "returns error if registration code attempts are exceeded" do
        registration_code = registration_codes(:valid_code)
        registration_code.update(attempts_count: 0)

        result = Users::ValidateRegistrationCode.call(user_params: @user_params)

        assert_not result.success?
        assert_equal "Validation attempts exceeded. Please contact the admin.", result.message
    end

    test "does not validate registration code if user role is not teacher" do
        user_params = @user_params.merge(role: "student")

        result = Users::ValidateRegistrationCode.call(user_params: user_params)

        assert result.success?
        assert_nil result.code
    end
end
