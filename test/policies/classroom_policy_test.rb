require 'test_helper'

class ClassroomPolicyTest < ActiveSupport::TestCase
    def setup
        @teacher_user = users(:math_classroom_teacher)
        @student_user = users(:student_user)
    end

    test 'teacher user authorized to call index' do
        policy = ClassroomPolicy.new(@teacher_user, User)

        assert policy.index?
    end

    test 'student user authorized to call index' do
        policy = ClassroomPolicy.new(@student_user, User)

        assert policy.index?
    end

    test 'teacher user authorized to call show' do
        policy = ClassroomPolicy.new(@teacher_user, User)

        assert policy.show?
    end

    test 'student user authorized to call show' do
        policy = ClassroomPolicy.new(@student_user, User)

        assert policy.show?
    end

    test 'teacher user authorized to call create' do
        policy = ClassroomPolicy.new(@teacher_user, User)

        assert policy.create?
    end

    test 'student user not authorized to call create' do
        policy = ClassroomPolicy.new(@student_user, User)

        assert_not policy.create?
    end

    test 'teacher user authorized to call update' do
        policy = ClassroomPolicy.new(@teacher_user, User)

        assert policy.update?
    end

    test 'student user not authorized to call update' do
        policy = ClassroomPolicy.new(@student_user, User)

        assert_not policy.update?
    end

    test 'teacher user authorized to call destroy' do
        policy = ClassroomPolicy.new(@teacher_user, User)

        assert policy.destroy?
    end

    test 'student user not authorized to call destroy' do
        policy = ClassroomPolicy.new(@student_user, User)

        assert_not policy.destroy?
    end
end