require 'test_helper'

class GetStudentsInteractorTest < ActiveSupport::TestCase
    def setup
        @classroom = classrooms(:classroom_one)
        @teacher = users(:teacher_user)
        @student1 = users(:student_user)
        @student2 = users(:student_user_2)
    end

    test "get enrolled students" do
        result = Classrooms::Students::GetStudents.call(classroom: @classroom, filter: "enrolled")

        assert result.success?
        assert_equal [@student1], result.students
    end

    test "get unenrolled students" do
        result = Classrooms::Students::GetStudents.call(classroom: @classroom, filter: "unenrolled")

        assert result.success?
        assert_equal [@student2], result.students
    end
end
