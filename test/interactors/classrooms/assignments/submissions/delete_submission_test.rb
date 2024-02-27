require 'test_helper'

class Classrooms::Assignments::Submissions::DeleteSubmissionTest < ActiveSupport::TestCase

    ERROR_MSG_DELETE_FAILED = Classrooms::Assignments::Submissions::DeleteSubmission::DELETE_FAILED
    ERROR_MSG_DOES_NOT_EXIST = Classrooms::Assignments::Submissions::DeleteSubmission::DOES_NOT_EXIST

    test "delete submission successfully" do
        math_submission = submissions(:submission_math_assignment_one)

        result = Classrooms::Assignments::Submissions::DeleteSubmission.call(assignment_id: math_submission[:assignment_id],submission_id: math_submission.id)

        assert result.success?
        assert_nil Submission.find_by(id: math_submission.id)
    end

    test "fail to delete non-existing submission" do
        math_submission = submissions(:submission_math_assignment_one)

        Submission.any_instance.stubs(:destroy).returns(false)

        result = Classrooms::Assignments::Submissions::DeleteSubmission.call(assignment_id: math_submission[:assignment_id], submission_id: 999)

        assert_not result.success?
        assert_equal :unprocessable_entity, result.status
        assert_equal ERROR_MSG_DOES_NOT_EXIST, result.message
        assert Submission.find_by(id: math_submission.id)
    end

    test "fail to delete submission" do
        math_submission = submissions(:submission_math_assignment_one)

        Submission.any_instance.stubs(:destroy).returns(false)

        result = Classrooms::Assignments::Submissions::DeleteSubmission.call(assignment_id: math_submission[:assignment_id],submission_id: math_submission.id)

        assert_not result.success?
        assert_equal :unprocessable_entity, result.status
        assert_equal ERROR_MSG_DELETE_FAILED, result.message
        assert Submission.find_by(id: math_submission.id)
    end
end
