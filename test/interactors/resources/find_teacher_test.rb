require 'test_helper'

class FindTeacherTest < ActiveSupport::TestCase
    test "successfully finds teacher when correct params are passed" do
        result = Resources::FindTeacher.call(classroom_id: 1)

        assert result.success?
        assert_not_nil result.teacher
        assert_not_nil result.teacher_id
    end

    test "fails if incorrect params are passed" do 
        result = Resources::FindTeacher.call(classroom_id: 0)

        assert_not result.success?
        assert_not_nil result.error
    end
end