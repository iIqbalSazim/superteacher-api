require 'test_helper'

class GetClassroomsByUserTest < ActiveSupport::TestCase

    test "should get classrooms for teacher user" do
        teacher_user = users(:math_teacher)

        classrooms_owned_by_teacher = [classrooms(:math_classroom)]

        result = Classrooms::GetClassroomsByUser.call(current_user: teacher_user)

        assert result.success?
        assert_equal classrooms_owned_by_teacher, result.classrooms
    end


    test "should get classrooms for student user" do
        student_user = users(:math_student)

        student_enrolled_classrooms = [classrooms(:math_classroom)]

        result = Classrooms::GetClassroomsByUser.call(current_user: student_user)

        assert result.success?
        assert_equal student_enrolled_classrooms, result.classrooms
    end

    test "should return empty array if no classrooms" do
        unenrolled_student = users(:unenrolled_student)

        result = Classrooms::GetClassroomsByUser.call(current_user: unenrolled_student)

        assert result.success?
        assert [], result.classroom
    end
end
