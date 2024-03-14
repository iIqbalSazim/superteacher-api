require 'test_helper'

class Classrooms::Assignments::Submissions::DeleteSubmissionTest < ActiveSupport::TestCase

    ERROR_MSG_DELETE_FAILED = Classrooms::Assignments::Submissions::DeleteSubmission::DELETE_FAILED
    ERROR_MSG_DOES_NOT_EXIST = Classrooms::Assignments::Submissions::DeleteSubmission::DOES_NOT_EXIST

    def setup
        @user = create(:user, :student)
        @classroom = create(:classroom)
        @resource = create(:resource, :assignment_resource, classroom: @classroom)
        @assignment = create(:assignment, resource_id: @resource.id)
    end

    test "delete submission successfully" do
        submission = create(:submission, assignment_id: @assignment.id, student_id: @user.id)

        result = Classrooms::Assignments::Submissions::DeleteSubmission.call(assignment_id: @assignment.id,submission_id: submission.id)

        assert result.success?
        assert_nil Submission.find_by(id: submission.id)
    end

    test "fail to delete non-existing submission" do
        non_existent_submission_id = 999

        result = Classrooms::Assignments::Submissions::DeleteSubmission.call(assignment_id: @assignment.id, submission_id: non_existent_submission_id)

        assert_not result.success?
        assert_equal :unprocessable_entity, result.status
        assert_equal ERROR_MSG_DOES_NOT_EXIST, result.message
    end

    test "fail to delete submission" do
        submission = create(:submission, assignment_id: @assignment.id, student_id: @user.id)

        Submission.any_instance.stubs(:destroy).returns(false)

        result = Classrooms::Assignments::Submissions::DeleteSubmission.call(assignment_id: @assignment.id,submission_id: submission.id)

        assert_not result.success?
        assert_equal :unprocessable_entity, result.status
        assert_equal ERROR_MSG_DELETE_FAILED, result.message
        assert Submission.find_by(id: submission.id)
    end
end
