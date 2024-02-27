require 'test_helper'

class Classrooms::DeleteClassroomTest < ActiveSupport::TestCase

    ERROR_MSG_CLASSROOM_DELETE_FAILED = Classrooms::DeleteClassroom::CLASSROOM_DELETE_FAILED

    test "delete classroom successfully" do
        math_classroom = classrooms(:math_classroom)

        result = Classrooms::DeleteClassroom.call(classroom: math_classroom)

        assert result.success?
        assert_nil Classroom.find_by(id: math_classroom.id)
    end

    test "fail to delete classroom" do
        math_classroom = classrooms(:math_classroom)

        math_classroom.stubs(:destroy).returns(false)

        result = Classrooms::DeleteClassroom.call(classroom: math_classroom)

        assert_not result.success?
        assert_equal :unprocessable_entity, result.status
        assert_equal ERROR_MSG_CLASSROOM_DELETE_FAILED, result.message
        assert Classroom.find_by(id: math_classroom.id)
    end
end
