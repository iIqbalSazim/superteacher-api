require 'test_helper'

class Classrooms::Exams::CreateNewExamTest < ActiveSupport::TestCase

    ERROR_MSG_SCHEDULE_EXAM_FAILED = Classrooms::Exams::CreateNewExam::SCHEDULE_EXAM_FAILED

    def setup
        @classroom = create(:classroom)
    end

    test "should create new exam with valid parameters" do
        valid_exam_params = attributes_for(:exam, classroom_id: @classroom.id)

        result = Classrooms::Exams::CreateNewExam.call(params: valid_exam_params)

        assert result.success?
        assert_not_nil result.exam
        assert result.exam.persisted?
    end

    test "should fail to create exam with invalid parameters" do
        invalid_exam_params = attributes_for(
                :exam, 
                classroom_id: @classroom.id,
                title: "",
                description: "",
                date: ""
            )

        result = Classrooms::Exams::CreateNewExam.call(params: invalid_exam_params)

        assert_not result.success?
        assert_equal ERROR_MSG_SCHEDULE_EXAM_FAILED, result.message
        assert_equal result.status, :unprocessable_entity
    end

    test "should fail with an error if exam creation fails" do
        valid_exam_params = attributes_for(:exam, classroom_id: @classroom.id)

        exam_mock = mock
        exam_mock.expects(:persisted?).returns(false)

        ExamRepository.expects(:create)
                      .with(valid_exam_params)
                      .returns(exam_mock)

        result = Classrooms::Exams::CreateNewExam.call(params: valid_exam_params)

        assert_not result.success?
        assert_equal ERROR_MSG_SCHEDULE_EXAM_FAILED, result.message
        assert_equal result.status, :unprocessable_entity
    end
end
