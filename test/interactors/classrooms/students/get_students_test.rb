require 'test_helper'

class GetStudentsTest < ActiveSupport::TestCase

    ENROLLED = User::ENROLLED_STUDENT
    UNENROLLED = User::UNENROLLED_STUDENT

    test "get enrolled students" do
        classroom = create(:classroom)

        enrolled_students = [
            create(:user, :math_student),
            create(:user, :math_student_two)
        ]

        classroom.students << enrolled_students

        result = Classrooms::Students::GetStudents.call(classroom: classroom, filter: ENROLLED)

        assert result.success?
        assert_equal enrolled_students, result.students
    end

    test "get unenrolled students" do
        classroom = create(:classroom)

        enrolled_student = create(:user, :math_student)
        unenrolled_student = create(:user, :unenrolled_student)

        classroom.students << enrolled_student

        result = Classrooms::Students::GetStudents.call(classroom: classroom, filter: UNENROLLED)

        assert result.success?
        assert result.students.include?(unenrolled_student)
        assert_not result.students.include?(enrolled_student)
    end

    test "returns empty array if no students are enrolled" do
        empty_classroom = create(:classroom)

        result = Classrooms::Students::GetStudents.call(classroom: empty_classroom, filter: ENROLLED)

        assert result.success?
        assert_equal [], result.students
    end
end
