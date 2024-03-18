require 'test_helper'

class Classrooms::Assignments::Submissions::GetSubmissionsTest < ActiveSupport::TestCase

    test "should get submissions by assignment_id" do
        user = create(:user, :student)
        resource = create(:resource, :assignment_resource)
        assignment = create(:assignment, resource_id: resource.id)

        existing_submissions = [
            create(:submission, assignment_id: assignment.id, student_id: user.id)
        ]

        assignment.submissions << existing_submissions

        result = Classrooms::Assignments::Submissions::GetSubmissions.call(assignment_id: assignment.id)

        assert result.success?
        assert_equal existing_submissions, result.submissions
    end

    test "should return empty array if no submissions" do
        resource = create(:resource, :assignment_resource)
        assignment = create(:assignment, resource: resource)

        result = Classrooms::Assignments::Submissions::GetSubmissions.call(assignment_id: assignment.id)

        assert result.success?
        assert_equal [], result.submissions
    end
end
