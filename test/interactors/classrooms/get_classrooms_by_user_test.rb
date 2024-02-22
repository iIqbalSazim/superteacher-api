require 'test_helper'

class GetClassroomsByUserTest < ActiveSupport::TestCase
    def setup
        @teacher_user = users(:math_classroom_teacher)
        @student_user = users(:student_user)
    end

    test "should get classrooms for teacher user" do
        result = Classrooms::GetClassroomsByUser.call(current_user: @teacher_user)

        assert result.success?
        assert_not_nil result.classrooms
    end

    test "should get classrooms for student user" do
        result = Classrooms::GetClassroomsByUser.call(current_user: @student_user)

        assert result.success?
        assert_not_nil result.classrooms
    end
end
