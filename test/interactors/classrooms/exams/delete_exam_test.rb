require 'test_helper'

class Classrooms::Exams::DeleteExamTest < ActiveSupport::TestCase

    ERROR_MSG_EXAM_DELETE_FAILED = Classrooms::Exams::DeleteExam::EXAM_DELETE_FAILED

    test "delete exam successfully" do
        math_exam = exams(:math_exam_one)

        result = Classrooms::Exams::DeleteExam.call(exam_id: math_exam.id)

        assert result.success?
        assert_nil Exam.find_by(id: math_exam.id)
    end

    test "fail to delete exam" do
        math_exam = exams(:math_exam_one)

        Exam.any_instance.stubs(:destroy).returns(false)

        result = Classrooms::Exams::DeleteExam.call(exam_id: math_exam.id)

        assert_not result.success?
        assert_equal :unprocessable_entity, result.status
        assert_equal ERROR_MSG_EXAM_DELETE_FAILED, result.message
        assert Exam.find_by(id: math_exam.id)
    end
end
