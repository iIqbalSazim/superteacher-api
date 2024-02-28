require 'test_helper'

class PasswordPolicyTest < ActiveSupport::TestCase
    def setup
        @teacher_user = users(:math_teacher)
        @student_user = users(:math_student)
    end

    test 'teacher user authorized to call reset' do
        policy = PasswordPolicy.new(@teacher_user, User)

        assert policy.reset?
    end

    test 'student user authorized to call reset' do
        policy = PasswordPolicy.new(@student_user, User)

        assert policy.reset?
    end
end