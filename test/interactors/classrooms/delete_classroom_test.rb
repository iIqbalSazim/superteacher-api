require 'test_helper'

class Classrooms::DeleteClassroomTest < ActiveSupport::TestCase
    def setup
        @classroom = classrooms(:math_classroom)
    end

    test "delete classroom successfully" do
        result = Classrooms::DeleteClassroom.call(classroom: @classroom)

        assert result.success?
        assert_nil Classroom.find_by(id: @classroom.id)
    end

    test "fail to delete non-existing classroom" do
        invalid_classroom = nil
        result = Classrooms::DeleteClassroom.call(classroom: invalid_classroom)

        assert_not result.success?
        assert_equal :unprocessable_entity, result.status
    end
end
