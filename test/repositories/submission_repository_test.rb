require "test_helper"

class SubmissionRepositoryTest < ActiveSupport::TestCase
    test "success if the SubmissionRepository extends base_repository" do
        assert_equal BaseRepository, SubmissionRepository.superclass
    end

    test "#klass matches Submission model" do
        assert_equal Submission, SubmissionRepository.send(:klass)
    end

    test "find_by_student_and_assignment_id should return a submission" do
        submission = create(:submission, student_id: 1, assignment_id: 1)

        result = SubmissionRepository.find_by_student_and_assignment_id(1, 1)

        assert_equal submission, result
    end

    test "find_by_student_and_assignment_id should return nil if submission does not exist" do

        result = SubmissionRepository.find_by_student_and_assignment_id(999, 999)

        assert_not result.present?
    end
end