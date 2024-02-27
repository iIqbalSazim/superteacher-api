require 'test_helper'

class Classrooms::Assignments::Submissions::CreateNewSubmissionTest < ActiveSupport::TestCase

    ERROR_MSG_SUBMISSION_FAILED = Classrooms::Assignments::Submissions::CreateNewSubmission::SUBMISSION_FAILED
    ERROR_MSG_EXISTING_SUBMISSION_ERROR = Classrooms::Assignments::Submissions::CreateNewSubmission::EXISTING_SUBMISSION_ERROR

    test "should create new submission with valid parameters" do
        valid_submission_params = {
            student_id: 12,
            assignment_id: 1,
            submitted_on: Date.today,
            url: "http://example.com",
        } 

        result = Classrooms::Assignments::Submissions::CreateNewSubmission.call(params: valid_submission_params)

        assert result.success?
        assert_not_nil result.submission
        assert result.submission.persisted?
    end

    test "should fail to create submission if submission already exists" do
        existing_submission = submissions(:submission_math_assignment_one)

        existing_submission_params = {
            student_id: existing_submission[:student_id],
            assignment_id: existing_submission[:assignment_id],
        } 

        result = Classrooms::Assignments::Submissions::CreateNewSubmission.call(params: existing_submission_params)

        assert_not result.success?
        assert_equal ERROR_MSG_EXISTING_SUBMISSION_ERROR, result.message
        assert_equal result.status, :unprocessable_entity
    end

    test "should fail to create submission with invalid parameters" do
        invalid_submission_params = {
            student_id: nil,
            assignment_id: nil,
            submitted_on: "",
            url: "",
        } 

        result = Classrooms::Assignments::Submissions::CreateNewSubmission.call(params: invalid_submission_params)

        assert_not result.success?
        assert_equal ERROR_MSG_SUBMISSION_FAILED, result.message
        assert_equal result.status, :unprocessable_entity
    end

    test "should fail with an error if submission creation fails" do
        valid_submission_params = {
            student_id: 12,
            assignment_id: 1,
            submitted_on: Date.today,
            url: "http://example.com",
        }  

        Submission.any_instance.stubs(:save).returns(false)

        result = Classrooms::Assignments::Submissions::CreateNewSubmission.call(params: valid_submission_params)

        assert_not result.success?
        assert_equal ERROR_MSG_SUBMISSION_FAILED, result.message
        assert_equal result.status, :unprocessable_entity
    end
end
