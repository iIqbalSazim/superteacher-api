require 'test_helper'

class Classrooms::Students::EnrollStudentTest < ActiveSupport::TestCase

    ERROR_MSG_STUDENT_ALREADY_ENROLLED = Classrooms::Students::EnrollStudent::STUDENT_ALREADY_ENROLLED
    ERROR_MSG_FAILED_TO_ENROLL_STUDENT = Classrooms::Students::EnrollStudent::FAILED_TO_ENROLL_STUDENT 

    def setup
        @classroom = create(:classroom)
    end

    test "successfully enrolls student" do
        unenrolled_student = create(:user, :unenrolled_student)

        params = {
            student_id: unenrolled_student.id,
            classroom: @classroom
        }

        result = Classrooms::Students::EnrollStudent.call(params)

        assert result.success?
        assert_not_nil result.student
    end

    test "fails to enroll student when record creation fails" do
        unenrolled_student = create(:user, :unenrolled_student)

        params = {
            student_id: unenrolled_student.id,
            classroom: @classroom
        }

        classroom_student_mock = mock
        classroom_student_mock.expects(:persisted?).returns(false)

        ClassroomStudentRepository.expects(:create)
                                  .with(classroom_id: @classroom.id, student_id: unenrolled_student.id)
                                  .returns(classroom_student_mock)

        result = Classrooms::Students::EnrollStudent.call(params)

        assert_not result.success?
        assert_nil result.student
        assert_equal ERROR_MSG_FAILED_TO_ENROLL_STUDENT, result.message
    end

    test "fails to enroll already enrolled student" do
        enrolled_student = create(:user, :student)

        @classroom.students << enrolled_student

        params = {
            student_id: enrolled_student.id,
            classroom: @classroom
        }

        result = Classrooms::Students::EnrollStudent.call(params)

        assert_not result.success?
        assert_nil result.student
        assert_equal ERROR_MSG_STUDENT_ALREADY_ENROLLED, result.message
    end
end
