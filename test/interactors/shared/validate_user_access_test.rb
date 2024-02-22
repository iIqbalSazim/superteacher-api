require 'test_helper'

class Shared::ValidateUserAccessTest < ActiveSupport::TestCase

    ERROR_MSG_CLASSROOM_NOT_FOUND = Shared::ValidateUserAccess::CLASSROOM_NOT_FOUND
    ERROR_MSG_YOU_ARE_NOT_AUTHORIZED = BaseInteractor::YOU_ARE_NOT_AUTHORIZED

    def setup
        @math_classroom = classrooms(:math_classroom)
    end

    test "teacher has access to the classroom they teach" do
        math_teacher = users(:math_teacher)

        result = Shared::ValidateUserAccess.call(current_user: math_teacher, classroom_id: @math_classroom.id)

        assert result.success?
    end

    test "teacher does not have access to a classroom they do not teach" do
        teacher_without_access = users(:biology_classroom_teacher)

        result = Shared::ValidateUserAccess.call(current_user: teacher_without_access, classroom_id: @math_classroom.id)

        assert_not result.success?
        assert_equal :forbidden, result.status
        assert_equal ERROR_MSG_YOU_ARE_NOT_AUTHORIZED, result.message
    end

    test "student has access to a classroom they are enrolled in" do
        enrolled_student = users(:math_student)

        result = Shared::ValidateUserAccess.call(current_user: enrolled_student, classroom_id: @math_classroom.id)

        assert result.success?
    end

    test "student does not have access to a classroom they are not enrolled in" do
        unenrolled_student = users(:unenrolled_student)

        result = Shared::ValidateUserAccess.call(current_user: unenrolled_student, classroom_id: @math_classroom.id)

        assert_not result.success?
        assert_equal :forbidden, result.status
        assert_equal ERROR_MSG_YOU_ARE_NOT_AUTHORIZED, result.message
    end

    test "throws error if classroom does not exist in the database" do
        enrolled_student = users(:math_student)
        non_existing_classroom_id = 999

        result = Shared::ValidateUserAccess.call(current_user: enrolled_student, classroom_id: non_existing_classroom_id)

        assert_not result.success?
        assert_equal :unprocessable_entity, result.status
        assert_equal ERROR_MSG_CLASSROOM_NOT_FOUND, result.message
    end
end
