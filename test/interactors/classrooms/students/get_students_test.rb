require 'test_helper'

class GetStudentsTest < ActiveSupport::TestCase

    ENROLLED = User::ENROLLED_STUDENT
    UNENROLLED = User::UNENROLLED_STUDENT

    test "get enrolled students" do
        math_classroom = classrooms(:math_classroom)
        enrolled_students = [
            users(:math_student),
            users(:math_student_two)
        ]

        result = Classrooms::Students::GetStudents.call(classroom: math_classroom, filter: ENROLLED)

        assert result.success?
        assert_equal enrolled_students, result.students
    end

    test "get unenrolled students" do
        math_classroom = classrooms(:math_classroom)
        unenrolled_students = [users(:unenrolled_student)]

        result = Classrooms::Students::GetStudents.call(classroom: math_classroom, filter: UNENROLLED)

        assert result.success?
        assert_equal unenrolled_students, result.students
    end

    test "returns empty array if no students are enrolled" do
        empty_classroom = classrooms(:empty_classroom)

        result = Classrooms::Students::GetStudents.call(classroom: empty_classroom, filter: ENROLLED)

        assert result.success?
        assert_equal [], result.students
    end
end
