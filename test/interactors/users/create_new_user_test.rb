require 'test_helper'

class Users::CreateNewUserTest < ActiveSupport::TestCase
    def setup
        @user_params = {
          email: "test@email.com",
          password: "password",
          first_name: "firstName",
          last_name: "lastName",
          gender: "Male",
          phone_number: "12345678911",
          role: "teacher"
        }
    end

  test "creates new user when correct params are passed" do
    result = Users::CreateNewUser.call(user_params: @user_params)

    assert result.success?
    assert_not_nil result.user_data
  end

  test "returns error if user already exists" do
    invalid_user_params = @user_params.dup
    invalid_user_params[:email] = users(:teacher_user)[:email]

    result = Users::CreateNewUser.call(user_params: invalid_user_params)

    assert_not result.success?
    assert_nil result.user_data
    assert_not_nil result.message
  end

  test "returns error if incorrect params are passed" do
    result = Users::CreateNewUser.call(user_params: { email: "test@user.com"})

    assert_not result.success?
    assert_nil result.user_data
    assert_not_nil result.message
  end
end