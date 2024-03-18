require "test_helper"

class Profiles::UpdateUserDetailsTest < ActiveSupport::TestCase

    ERROR_MSG_USER_DOES_NOT_EXIST = Profiles::UpdateUserDetails::USER_DOES_NOT_EXIST 
    ERROR_MSG_FAILED_TO_UPDATE = Profiles::UpdateUserDetails::FAILED_TO_UPDATE 

    test "should update user details with valid parameters" do
        teacher_user = create(:user, :teacher)

        params = {
            first_name: "John",
            last_name: "Doe",
            gender: "Male",
            phone_number: "92087615662"
        }

        params_mock = mock
        params_mock.expects(:permit).with(:first_name, :last_name, :gender, :phone_number).returns(params)

        result = Profiles::UpdateUserDetails.call(params: params_mock, user_id: teacher_user.id)

        assert result.success?
        assert_equal params[:first_name], result.user.first_name
        assert_equal params[:last_name], result.user.last_name
        assert_equal params[:gender], result.user.gender
    end

    test "should throw error if user does not exist" do
        non_existent_user_id = 999

        result = Profiles::UpdateUserDetails.call(params: {}, user_id: non_existent_user_id)

        assert_not result.success?
        assert_equal ERROR_MSG_USER_DOES_NOT_EXIST, result.message
    end

    test "should throw error if user fails to update" do
        teacher_user = create(:user, :teacher)

        params = {
            first_name: "John",
            last_name: "Doe",
            gender: "Male",
            phone_number: "92087615662"
        }

        params_mock = mock
        params_mock.expects(:permit).with(:first_name, :last_name, :gender, :phone_number).returns(params)

        teacher_update_mock = mock
        teacher_update_mock.expects(:valid?).returns(false)

        UserRepository.expects(:update)
                      .with(teacher_user, params)
                      .returns(teacher_update_mock)

        result = Profiles::UpdateUserDetails.call(params: params_mock, user_id: teacher_user.id)

        assert_not result.success?
        assert_equal ERROR_MSG_FAILED_TO_UPDATE, result.message
    end
end
