require 'test_helper'

class ProfilePolicyTest < ActiveSupport::TestCase
    def setup
        @teacher_user = users(:math_teacher)
        @student_user = users(:math_student)
    end

    test 'teacher user authorized to call update' do
        policy = ProfilePolicy.new(@teacher_user, User)

        assert policy.update?
    end

    test 'student user authorized to call update' do
        policy = ProfilePolicy.new(@student_user, User)

        assert policy.update?
    end
end