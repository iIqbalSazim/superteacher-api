require 'test_helper'

class CreateClassroomTest < ActiveSupport::TestCase

    ERROR_MSG_FAILED_TO_CREATE = Classrooms::CreateClassroom::FAILED_TO_CREATE

    test "creates new classroom when correct params are passed" do
        classroom_params = {
            title: "Mathematics",
            subject: "Math",
            class_time: "10:00 AM",
            days: ["Monday", "Wednesday", "Friday"],
            teacher_id: users(:math_teacher).id
        }

        result = Classrooms::CreateClassroom.call(classroom_params: classroom_params)

        assert result.success?
        assert_not_nil result.new_classroom
    end

    test "returns error if classroom creation fails" do
        invalid_classroom_params = {
            title: "",
            subject: "Math",
            class_time: "10:00 AM",
            days: ["Monday", "Wednesday", "Friday"],
            teacher_id: users(:math_teacher).id
        }

        result = Classrooms::CreateClassroom.call(classroom_params: invalid_classroom_params)

        assert_not result.success?
        assert_nil result.new_classroom
        assert_equal ERROR_MSG_FAILED_TO_CREATE, result.message
    end
end