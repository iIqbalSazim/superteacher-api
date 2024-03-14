require 'test_helper'

class CreateClassroomTest < ActiveSupport::TestCase

    ERROR_MSG_FAILED_TO_CREATE = Classrooms::CreateClassroom::FAILED_TO_CREATE

    test "creates new classroom when correct params are passed" do
        teacher = create(:user, :math_teacher)
        classroom_params = attributes_for(:classroom, teacher_id: teacher.id)

        result = Classrooms::CreateClassroom.call(classroom_params: classroom_params)

        assert result.success?
        assert_not_nil result.new_classroom
    end

    test "returns error if classroom creation fails" do
        teacher = create(:user, :math_teacher)
        invalid_classroom_params = attributes_for(:classroom, title: "", teacher_id: teacher.id)

        result = Classrooms::CreateClassroom.call(classroom_params: invalid_classroom_params)

        assert_not result.success?
        assert_nil result.new_classroom
        assert_equal ERROR_MSG_FAILED_TO_CREATE, result.message
    end
end