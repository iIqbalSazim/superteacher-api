require 'test_helper'

class Classrooms::ResourcePolicyTest < ActiveSupport::TestCase
    def setup
        @teacher_user = create(:user, :teacher)
        @student_user = create(:user, :student)
    end

    test 'teacher user authorized to call index' do
        policy = Classrooms::ResourcePolicy.new(@teacher_user, User)

        assert policy.index?
    end

    test 'student user authorized to call index' do
        policy = Classrooms::ResourcePolicy.new(@student_user, User)

        assert policy.index?
    end

    test 'teacher user authorized to call create' do
        policy = Classrooms::ResourcePolicy.new(@teacher_user, User)

        assert policy.create?
    end

    test 'student user not authorized to call create' do
        policy = Classrooms::ResourcePolicy.new(@student_user, User)

        assert_not policy.create?
    end

    test 'teacher user authorized to call update' do
        policy = Classrooms::ResourcePolicy.new(@teacher_user, User)

        assert policy.update?
    end

    test 'student user not authorized to call update' do
        policy = Classrooms::ResourcePolicy.new(@student_user, User)

        assert_not policy.update?
    end

    test 'teacher user authorized to call destroy' do
        policy = Classrooms::ResourcePolicy.new(@teacher_user, User)

        assert policy.destroy?
    end

    test 'student user not authorized to call destroy' do
        policy = Classrooms::ResourcePolicy.new(@student_user, User)

        assert_not policy.destroy?
    end
end