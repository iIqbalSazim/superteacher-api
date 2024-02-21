require 'test_helper'

class Shared::ValidateUserAccessTest < ActiveSupport::TestCase
    def setup
        @teacher_with_classroom = users(:teacher_user)
        @teacher_without_classroom = users(:teacher_user_2)
        @student = users(:student_user)
        @not_enrolled_student = users(:student_user_2)
        @classroom = classrooms(:classroom_one)
    end

    test "teacher has access to the classroom they teach" do
        result = Shared::ValidateUserAccess.call(current_user: @teacher_with_classroom, classroom_id: @classroom.id)

        assert result.success?
    end

    test "teacher does not have access to a classroom they do not teach" do
        result = Shared::ValidateUserAccess.call(current_user: @teacher_without_classroom, classroom_id: @classroom.id)

        assert_not result.success?
        assert_equal :forbidden, result.status
    end

    test "student has access to a classroom they are enrolled in" do
        result = Shared::ValidateUserAccess.call(current_user: @student, classroom_id: @classroom.id)

        assert result.success?
    end

    test "student does not have access to a classroom they are not enrolled in" do
        result = Shared::ValidateUserAccess.call(current_user: @not_enrolled_student, classroom_id: @classroom.id)

        assert_not result.success?
        assert_equal :forbidden, result.status
    end
end
