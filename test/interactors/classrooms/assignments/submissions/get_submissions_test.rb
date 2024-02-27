require 'test_helper'

class Classrooms::Assignments::Submissions::GetSubmissionsTest < ActiveSupport::TestCase

    test "should get submissions by assignment_id" do
        assignment_id = assignments(:math_assignment_one).id

        existing_submissions = [submissions(:submission_math_assignment_one)]

        result = Classrooms::Assignments::Submissions::GetSubmissions.call(assignment_id: assignment_id)

        assert result.success?
        assert_equal existing_submissions, result.submissions
    end

    test "should return empty array if no submissions" do
        assignment_with_no_submissions = assignments(:math_assignment_two)

        result = Classrooms::Assignments::Submissions::GetSubmissions.call(assignment_id: assignment_with_no_submissions.id)

        assert result.success?
        assert_equal [], result.submissions
    end
end
