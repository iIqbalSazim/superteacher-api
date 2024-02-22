require 'test_helper'

class UserSerializerTest < ActiveSupport::TestCase
    test 'should render correct attributes if user is a teacher' do
        user_data = users(:math_teacher)

        serialized_object = UserSerializer.new.serialize(user_data)
        parsed_object = JSON.parse(serialized_object.to_json)

        assert_equal user_data[:id], parsed_object['id']
        assert_equal user_data[:email], parsed_object['email']
        assert_equal user_data[:first_name], parsed_object['first_name']
        assert_equal user_data[:last_name], parsed_object['last_name']
        assert_equal user_data[:gender], parsed_object['gender']
        assert_equal user_data[:role], parsed_object['role']
        assert_nil user_data.student_profile
        assert_not_nil user_data.teacher_profile
    end

    test 'should render correct attributes if user is a student' do
        user_data = users(:math_student)

        serialized_object = UserSerializer.new.serialize(user_data)
        parsed_object = JSON.parse(serialized_object.to_json)

        assert_equal user_data[:id], parsed_object['id']
        assert_equal user_data[:email], parsed_object['email']
        assert_equal user_data[:first_name], parsed_object['first_name']
        assert_equal user_data[:last_name], parsed_object['last_name']
        assert_equal user_data[:gender], parsed_object['gender']
        assert_equal user_data[:role], parsed_object['role']
        assert_equal user_data[:phone_number], parsed_object['phone_number']
        assert_not_nil user_data.student_profile
        assert_nil user_data.teacher_profile
    end
end