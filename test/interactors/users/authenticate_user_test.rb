require 'test_helper'

class Users::AuthenticateUserTest < ActiveSupport::TestCase

  ERROR_MSG_INVALID_CREDENTIALS = Users::AuthenticateUser::INVALID_CREDENTIALS

  test "authenticates user when correct credentials are passed" do
    existing_user = create(:user, :teacher)

    user_params = {
        email: existing_user[:email],
        password: existing_user[:password]
    }

    user_mock = mock("find_user_mock")
    user_mock.expects(:authenticate).with(user_params[:password]).returns(true)

    UserRepository.expects(:find_user_by_email)
                  .with(user_params[:email])
                  .returns(user_mock)

    result = Users::AuthenticateUser.call(user_params: user_params)

    assert result.success?
    assert_not_nil result.user_data
  end

  test "returns error if invalid email" do
    email = "fake@email.com"

    UserRepository.expects(:find_user_by_email)
                  .with(email)
                  .returns(false)

    result = Users::AuthenticateUser.call(user_params: { email: email })

    assert_not result.success?
    assert_nil result.user_data
    assert_equal ERROR_MSG_INVALID_CREDENTIALS, result.message
  end

  test "returns error if invalid password" do
    existing_user = create(:user, :teacher)

    user_params = {
        email: existing_user.email,
        password: "wrong password"
    }

    user_mock = mock("find_user_mock")
    user_mock.expects(:authenticate).with(user_params[:password]).returns(false)

    UserRepository.expects(:find_user_by_email)
                  .with(user_params[:email])
                  .returns(user_mock)

    result = Users::AuthenticateUser.call(user_params: user_params)

    assert_not result.success?
    assert_nil result.user_data
    assert_equal ERROR_MSG_INVALID_CREDENTIALS, result.message
  end
end