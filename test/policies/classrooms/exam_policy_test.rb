require 'test_helper'

class Classrooms::ExamPolicyTest < ActiveSupport::TestCase
    def setup
        @teacher_user = users(:math_teacher)
        @student_user = users(:math_student)
    end

    test 'teacher user authorized to call index' do
        policy = Classrooms::ExamPolicy.new(@teacher_user, User)

        assert policy.index?
    end

    test 'student user authorized to call index' do
        policy = Classrooms::ExamPolicy.new(@student_user, User)

        assert policy.index?
    end
end