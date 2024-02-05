require 'test_helper'

class FindClassroomTest < ActiveSupport::TestCase
    test "successfully find classroom when correct params are passed" do
        result = Shared::FindClassroom.call(classroom_id: 1)

        assert result.success?
        assert_not_nil result.classroom
    end


    test "fails to find classroom when incorrect params are passed" do
        result = Shared::FindClassroom.call(classroom_id: 5)

        assert_not result.success?
        assert_not_nil result.error
    end
end