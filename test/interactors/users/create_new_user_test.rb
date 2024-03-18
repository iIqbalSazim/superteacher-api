require 'test_helper'

class Users::CreateNewUserTest < ActiveSupport::TestCase

  ERROR_MSG_USER_ALREADY_EXISTS = Users::CreateNewUser::USER_ALREADY_EXISTS
  ERROR_MSG_FAILED_TO_SAVE_USER = Users::CreateNewUser::FAILED_TO_SAVE_USER

  test "creates new user when correct params are passed" do
    user_params = attributes_for(:user, :teacher)

    user_mock = mock("user_mock", valid?: true)

    UserRepository.expects(:create)
                  .with(user_params)
                  .returns(user_mock)

    result = Users::CreateNewUser.call(user_params: user_params)

    assert result.success?
    assert_not_nil result.user_data
  end

  test "returns error if user already exists" do
    existing_user = create(:user, :math_teacher)

    find_user_mock = mock("find_user_mock", present?: true)

    UserRepository.expects(:find_user_by_email)
                  .with(existing_user[:email])
                  .returns(find_user_mock)

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