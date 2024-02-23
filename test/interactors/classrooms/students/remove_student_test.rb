require 'test_helper'

class Classrooms::Students::RemoveStudentTest < ActiveSupport::TestCase

    ERROR_MSG_STUDENT_IS_NOT_ENROLLED = Classrooms::Students::RemoveStudent::STUDENT_IS_NOT_ENROLLED
    ERROR_MSG_FAILED_TO_REMOVE_STUDENT = Classrooms::Students::RemoveStudent::FAILED_TO_REMOVE_STUDENT 

    def setup
        @classroom = classrooms(:math_classroom)
    end

    test "successfully unenrolls student" do
        enrolled_student = classroom_students(:math_student_one)

        params = {
            student_id: enrolled_student.student_id,
            classroom: @classroom
        }

        result = Classrooms::Students::RemoveStudent.call(params)

        assert result.success?
        assert_not_nil result.removed_student
    end

    test "fails to unenroll student if enrollment does not exist" do
        unenrolled_student = users(:unenrolled_student)

        params = {
            student_id: unenrolled_student.id,
            classroom: @classroom
        } 

        result = Classrooms::Students::RemoveStudent.call(params)

        assert_not result.success?
        assert_nil result.removed_student
        assert_equal ERROR_MSG_STUDENT_IS_NOT_ENROLLED, result.message
        assert_equal :unprocessable_entity, result.status
    end

    test "fails to remove enrollment if record destroy fails" do
        enrolled_student = classroom_students(:math_student_two)

        params = {
            student_id: enrolled_student.student_id,
            classroom: @classroom
        } 

        ClassroomStudent.any_instance.stubs(:destroy).returns(false)

        result = Classrooms::Students::RemoveStudent.call(params)

        assert_not result.success?
        assert_nil result.removed_student
        assert_equal ERROR_MSG_FAILED_TO_REMOVE_STUDENT, result.message
        assert_equal :unprocessable_entity, result.status
    end
end
