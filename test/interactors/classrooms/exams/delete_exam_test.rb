require 'test_helper'

class Classrooms::Exams::DeleteExamTest < ActiveSupport::TestCase

    ERROR_MSG_EXAM_DELETE_FAILED = Classrooms::Exams::DeleteExam::EXAM_DELETE_FAILED

    test "delete exam successfully" do
        exam = create(:exam)

        result = Classrooms::Exams::DeleteExam.call(exam_id: exam.id)

        assert result.success?
        assert_nil Exam.find_by(id: exam.id)
    end

    test "fail to delete exam" do
        exam = create(:exam)

        exam_mock = mock

        ExamRepository.expects(:find_by_id)
                      .with(exam.id)
                      .returns(exam_mock)

        ExamRepository.expects(:destroy)
                      .with(exam_mock)
                      .returns(false)

        result = Classrooms::Exams::DeleteExam.call(exam_id: exam.id)

        assert_not result.success?
        assert_equal :unprocessable_entity, result.status
        assert_equal ERROR_MSG_EXAM_DELETE_FAILED, result.message
    end
end
