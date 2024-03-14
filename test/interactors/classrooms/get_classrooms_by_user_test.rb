require 'test_helper'

class GetClassroomsByUserTest < ActiveSupport::TestCase

    test "should get classrooms for teacher user" do
        teacher_user = create(:user, :math_teacher) 

        classroom = create(:classroom, teacher: teacher_user)

        result = Classrooms::GetClassroomsByUser.call(current_user: teacher_user)

        assert result.success?
        assert_equal [classroom], result.classrooms
    end


    test "should get classrooms for student user" do
        student_user = create(:user, :student)

        classroom = create(:classroom)
        biology_classroom = create(:classroom, :biology)

        classroom.students << student_user
        biology_classroom.students << student_user

        result = Classrooms::GetClassroomsByUser.call(current_user: student_user)

        assert result.success?
        assert_equal [classroom, biology_classroom], result.classrooms
    end

    test "should return empty array if no classrooms" do
        unenrolled_student = create(:user, :unenrolled_student)

        result = Classrooms::GetClassroomsByUser.call(current_user: unenrolled_student)

        assert result.success?
        assert [], result.classroom
    end
end
