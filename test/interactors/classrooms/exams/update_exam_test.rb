require 'test_helper'

class Classrooms::Exams::UpdateExamTest < ActiveSupport::TestCase

    ERROR_MSG_EXAM_UPDATE_FAILED = Classrooms::Exams::UpdateExam::EXAM_UPDATE_FAILED

    def setup
        @classroom = create(:classroom)
        @exam = create(:exam, classroom: @classroom)
    end

    test "update exam with valid parameters" do
        valid_exam_params = attributes_for(:exam, classroom: @classroom)

        result = Classrooms::Exams::UpdateExam.call(
            params: valid_exam_params, 
            exam_id: @exam.id 
        )

        assert result.success?
        assert_equal valid_exam_params[:title], result.exam.title
        assert_equal valid_exam_params[:description], result.exam.description
        assert_equal DateTime.parse(valid_exam_params[:date]), result.exam.date
    end

    test "fail to update exam with invalid parameters" do
        invalid_exam_params = attributes_for(:exam, classroom: @classroom, title: "")

        result = Classrooms::Exams::UpdateExam.call(
            params: invalid_exam_params, 
            exam_id: @exam.id 
        )

        assert_not result.success?
        assert_equal ERROR_MSG_EXAM_UPDATE_FAILED, result.message
        assert_equal :unprocessable_entity, result.status
    end
end
