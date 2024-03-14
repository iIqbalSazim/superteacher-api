require 'test_helper'

class Profiles::UpdateUserDetailsTest < ActiveSupport::TestCase

    ERROR_MSG_USER_DOES_NOT_EXIST = Profiles::UpdateUserDetails::USER_DOES_NOT_EXIST 

    test 'should update user details with valid parameters' do
        teacher_user = create(:user, :teacher)

        params = {
            first_name: 'John',
            last_name: 'Doe',
            gender: 'Male',
            phone_number: '92087615662'
        }

        params.stubs(:permit).returns(params)

        result = Profiles::UpdateUserDetails.call(params: params, user_id: teacher_user.id)

        assert result.success?
        assert_equal params[:first_name], result.user.first_name
        assert_equal params[:last_name], result.user.last_name
        assert_equal params[:gender], result.user.gender
    end

    test 'should fail if user does not exist' do
        non_existent_user_id = 999

        params = {
            first_name: 'John',
            last_name: 'Doe',
            gender: 'Male'
        }

        result = Profiles::UpdateUserDetails.call(params: params, user_id: non_existent_user_id)

        assert_not result.success?
        assert_equal ERROR_MSG_USER_DOES_NOT_EXIST, result.message
    end
end
