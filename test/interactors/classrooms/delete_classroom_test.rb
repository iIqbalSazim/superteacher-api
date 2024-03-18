require 'test_helper'

class Classrooms::DeleteClassroomTest < ActiveSupport::TestCase

    ERROR_MSG_CLASSROOM_DELETE_FAILED = Classrooms::DeleteClassroom::CLASSROOM_DELETE_FAILED

    test "delete classroom successfully" do
        classroom = create(:classroom)

        result = Classrooms::DeleteClassroom.call(classroom: classroom)

        assert result.success?
        assert_nil Classroom.find_by(id: classroom.id)
    end

    test "fail to delete classroom" do
        classroom = create(:classroom)

        ClassroomRepository.expects(:destroy)
                           .with(classroom)
                           .returns(false)

        result = Classrooms::DeleteClassroom.call(classroom: classroom)

        assert_not result.success?
        assert_equal :unprocessable_entity, result.status
        assert_equal ERROR_MSG_CLASSROOM_DELETE_FAILED, result.message
        assert Classroom.find_by(id: classroom.id)
    end
end
