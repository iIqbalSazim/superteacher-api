require 'test_helper'

class Classrooms::Assignments::SubmisssionPolicyTest < ActiveSupport::TestCase
    def setup
        @teacher_user = users(:math_teacher)
        @student_user = users(:math_student)
    end

    test 'teacher user authorized to call index' do
        policy = Classrooms::Assignments::SubmissionPolicy.new(@teacher_user, User)

        assert policy.index?
    end

    test 'student user not authorized to call index' do
        policy = Classrooms::Assignments::SubmissionPolicy.new(@student_user, User)

        assert_not policy.index?
    end

    test 'teacher user not authorized to call create' do
        policy = Classrooms::Assignments::SubmissionPolicy.new(@teacher_user, User)

        assert_not policy.create?
    end

    test 'student user authorized to call create' do
        policy = Classrooms::Assignments::SubmissionPolicy.new(@student_user, User)

        assert policy.create?
    end

    test 'teacher user not authorized to call destroy' do
        policy = Classrooms::Assignments::SubmissionPolicy.new(@teacher_user, User)

        assert_not policy.destroy?
    end

    test 'student user authorized to call destroy' do
        policy = Classrooms::Assignments::SubmissionPolicy.new(@student_user, User)

        assert policy.destroy?
    end
end