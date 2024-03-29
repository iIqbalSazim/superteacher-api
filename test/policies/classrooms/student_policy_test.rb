require 'test_helper'

class Classrooms::StudentPolicyTest < ActiveSupport::TestCase
    def setup
        @teacher_user = create(:user, :teacher)
        @student_user = create(:user, :student)
    end

    test 'teacher user is authorized to call index' do
        policy = Classrooms::StudentPolicy.new(@teacher_user, User)

        assert policy.index?
    end

    test 'student user is authorized to call index' do
        policy = Classrooms::StudentPolicy.new(@student_user, User)

        assert policy.index?
    end

    test 'teacher user is authorized to call enroll' do
        policy = Classrooms::StudentPolicy.new(@teacher_user, User)

        assert policy.enroll?
    end

    test 'student user is not authorized to call enroll' do
        policy = Classrooms::StudentPolicy.new(@student_user, User)

        assert_not policy.enroll?
    end


    test 'teacher user is authorized to call remove' do
        policy = Classrooms::StudentPolicy.new(@teacher_user, User)

        assert policy.remove?
    end

    test 'student user is not authorized to call remove' do
        policy = Classrooms::StudentPolicy.new(@student_user, User)

        assert_not policy.remove?
    end
end