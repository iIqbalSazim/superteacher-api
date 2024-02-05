require 'test_helper'

class DeleteClassroomTest < ActiveSupport::TestCase
    test "successfully deletes classroom when correct params are passed" do
        existing = Classroom.find_by(id: 1)

        result = Classrooms::DeleteClassroom.call(classroom: existing)

        assert result.success?
        assert_nil Classroom.find_by(id: 1)
    end

    test "fails to delete classroom when incorrect params are passed" do
        result = Classrooms::DeleteClassroom.call(classroom: nil)

        assert_not result.success?
        assert_not_nil result.error
    end
end