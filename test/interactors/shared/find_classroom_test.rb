require 'test_helper'

class FindClassroomTest < ActiveSupport::TestCase

    ERROR_MSG_CLASSROOM_NOT_FOUND = Shared::FindClassroom::CLASSROOM_NOT_FOUND

    test "finds the classroom when valid id is passed" do
        classroom = create(:classroom)

        result = Shared::FindClassroom.call(classroom_id: classroom.id)

        assert result.success?
        assert_not_nil result.classroom
        assert_equal classroom, result.classroom
    end

    test "returns error if classroom with id does not exist" do
        non_existing_classroom_id = 999

        result = Shared::FindClassroom.call(classroom_id: non_existing_classroom_id)

        assert_not result.success?
        assert_nil result.classroom
        assert_equal ERROR_MSG_CLASSROOM_NOT_FOUND, result.message
    end
end
