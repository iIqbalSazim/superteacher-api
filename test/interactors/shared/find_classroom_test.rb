require 'test_helper'

class FindClassroomTest < ActiveSupport::TestCase
    test "finds the classroom when valid id is passed" do
        classroom_id = classrooms(:classroom_one).id

        result = Shared::FindClassroom.call(classroom_id: classroom_id)

        assert result.success?
        assert_not_nil result.classroom
        assert_equal classroom_id, result.classroom.id
    end

    test "returns error if classroom with invalid id is passed" do
        classroom_id = 999

        result = Shared::FindClassroom.call(classroom_id: classroom_id)

        assert_not result.success?
        assert_nil result.classroom
        assert_not_nil result.message
    end

    test "returns error if required params are missing" do
        result = Shared::FindClassroom.call(classroom_id: nil)

        assert_not result.success?
        assert_nil result.classroom
        assert_not_nil result.message
    end
end
