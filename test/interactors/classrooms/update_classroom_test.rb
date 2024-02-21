require 'test_helper'

class Classrooms::UpdateClassroomTest < ActiveSupport::TestCase
    def setup
        @classroom = classrooms(:classroom_one)
        @classroom_params = {
            title: "Updated Classroom",
            subject: "Updated Subject",
            days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        }
    end

    test "update classroom with valid parameters" do
        result = Classrooms::UpdateClassroom.call(classroom_params: @classroom_params, classroom: @classroom)

        assert result.success?
        assert_equal "Updated Classroom", result.updated_classroom.title
        assert_equal "Updated Subject", result.updated_classroom.subject
    end

    test "fail to update classroom with invalid parameters" do
        invalid_params = { title: "" }
        result = Classrooms::UpdateClassroom.call(classroom_params: invalid_params, classroom: @classroom)

        assert_not result.success?
        assert_equal "Classroom failed to update", result.message
        assert_equal :unprocessable_entity, result.status
    end
end
