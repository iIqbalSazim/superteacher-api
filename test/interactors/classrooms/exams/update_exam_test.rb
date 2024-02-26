require 'test_helper'

class Classrooms::Exams::UpdateExamTest < ActiveSupport::TestCase

    ERROR_MSG_EXAM_UPDATE_FAILED = Classrooms::Exams::UpdateExam::EXAM_UPDATE_FAILED

    test "update exam with valid parameters" do
        valid_exam_params = {
            title: "Exam title",
            description: "Exam description",
            classroom_id: 1,
            date: "29 Feb, 2024"
        }

        result = Classrooms::Exams::UpdateExam.call(
            params: valid_exam_params, 
            exam_id: 1 
        )

        assert result.success?
        assert_equal valid_exam_params[:title], result.exam.title
        assert_equal valid_exam_params[:description], result.exam.description
        assert_equal DateTime.parse(valid_exam_params[:date]), result.exam.date
    end

    test "fail to update exam with invalid parameters" do
        invalid_exam_params = {
            title: ""
        }

        result = Classrooms::Exams::UpdateExam.call(
            params: invalid_exam_params, 
            exam_id: 1 
        )

        assert_not result.success?
        assert_equal ERROR_MSG_EXAM_UPDATE_FAILED, result.message
        assert_equal :unprocessable_entity, result.status
    end
end
