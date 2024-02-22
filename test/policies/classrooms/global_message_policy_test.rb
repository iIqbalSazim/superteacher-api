require 'test_helper'

class Classrooms::GlobalMessagePolicyTest < ActiveSupport::TestCase
    def setup
        @teacher_user = users(:teacher_user)
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
end