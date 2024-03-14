require 'test_helper'

class ProfilePolicyTest < ActiveSupport::TestCase
    def setup
        @teacher_user = create(:user, :teacher)
        @student_user = create(:user, :student)
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