require 'test_helper'

class Classrooms::GlobalMessagePolicyTest < ActiveSupport::TestCase
    def setup
        @teacher_user = users(:math_classroom_teacher)
        @student_user = users(:student_user)
    end

    test 'teacher user authorized to call index' do
        policy = Classrooms::GlobalMessagePolicy.new(@teacher_user, User)

        assert policy.index?
    end

    test 'student user authorized to call index' do
        policy = Classrooms::GlobalMessagePolicy.new(@student_user, User)

        assert policy.index?
    end

    test 'teacher user authorized to call create' do
        policy = Classrooms::GlobalMessagePolicy.new(@teacher_user, User)

        assert policy.create?
    end

    test 'student user authorized to call create' do
        policy = Classrooms::GlobalMessagePolicy.new(@student_user, User)

        assert policy.create?
    end
end