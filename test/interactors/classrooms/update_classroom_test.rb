require 'test_helper'

class Classrooms::UpdateClassroomTest < ActiveSupport::TestCase

    ERROR_MSG_CLASSROOM_FAILED_TO_UPDATE = Classrooms::UpdateClassroom::CLASSROOM_FAILED_TO_UPDATE

    def setup
        @classroom = create(:classroom)
    end

    test "update classroom with valid parameters" do
        classroom_params = {
            title: "Updated Classroom",
            subject: "Updated Subject",
            days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        }

        result = Classrooms::UpdateClassroom.call(
            classroom_params: classroom_params, 
            classroom: @classroom
        )

        assert result.success?
        assert_equal "Updated Classroom", result.updated_classroom.title
        assert_equal "Updated Subject", result.updated_classroom.subject
    end

    test "fail to update classroom with invalid parameters" do
        invalid_params = {
            title: ""
        }

        result = Classrooms::UpdateClassroom.call(
            classroom_params: invalid_params,
            classroom: @classroom
        )

        assert_not result.success?
        assert_equal ERROR_MSG_CLASSROOM_FAILED_TO_UPDATE, result.message
        assert_equal :unprocessable_entity, result.status
    end
end
