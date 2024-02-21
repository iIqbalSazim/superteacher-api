require 'test_helper'

class CreateClassroomTest < ActiveSupport::TestCase

    def setup
        @classroom_params = { 
            title: "Mathematics",
            subject: "Math",
            class_time: "10:00 AM",
            days: ["Monday", "Wednesday", "Friday"],
            teacher_id: users(:teacher_user).id
        }
    end

    test "creates new classroom when correct params are passed" do
        result = Classrooms::CreateClassroom.call(classroom_params: @classroom_params)

        assert result.success?
        assert_not_nil result.new_classroom
    end

    test "returns error if classroom creation fails" do
        invalid_classroom_params = @classroom_params.dup 
        invalid_classroom_params[:title] = ""

        result = Classrooms::CreateClassroom.call(classroom_params: invalid_classroom_params)

        assert_not result.success?
        assert_nil result.new_classroom
        assert_not_nil result.message
    end

    test "returns error if required params are missing" do
        result = Classrooms::CreateClassroom.call(classroom_params: {})

        assert_not result.success?
        assert_nil result.new_classroom
        assert_not_nil result.message
    end
end
