require 'test_helper'

class Users::CreateNewUserTest < ActiveSupport::TestCase

  ERROR_MSG_USER_ALREADY_EXISTS = Users::CreateNewUser::USER_ALREADY_EXISTS
  ERROR_MSG_FAILED_TO_SAVE_USER = Users::CreateNewUser::FAILED_TO_SAVE_USER

  test "creates new user when correct params are passed" do
    user_params = {
      email: "test@email.com",
      password: "password",
      first_name: "firstName",
      last_name: "lastName",
      gender: "Male",
      role: "teacher",
    }

    result = Users::CreateNewUser.call(user_params: user_params)

    assert result.success?
    assert_not_nil result.user_data
  end

  test "returns error if user already exists" do
    existing_user = create(:user, :math_teacher)

    result = Users::CreateNewUser.call(user_params: { email: existing_user.email })

    assert_not result.success?
    assert_nil result.user_data
    assert_equal ERROR_MSG_USER_ALREADY_EXISTS, result.message
  end

  test "returns error if incorrect params are passed" do
    result = Users::CreateNewUser.call(user_params: {})

    assert_not result.success?
    assert_nil result.user_data
    assert_equal ERROR_MSG_FAILED_TO_SAVE_USER, result.message
  end
end