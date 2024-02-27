require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
    should belong_to(:assignment)

    should validate_presence_of(:student_id)
    should validate_presence_of(:assignment_id)
    should validate_presence_of(:submitted_on)
    should validate_presence_of(:url)

    def setup
        @student = users(:math_student_two)
        @assignment = assignments(:math_assignment_one)
    end

    test "submission is created with validations passing" do
        valid_submission = Submission.new(
            student_id: @student.id,
            assignment_id: @assignment.id,
            submitted_on: Date.today,
            url: "http://example.com",
        )

        assert valid_submission.valid?
        assert_empty valid_submission.errors
    end

    test "submission fails to create with validations failing" do
        invalid_submission = Submission.new

        assert_not invalid_submission.valid?
        assert_not_empty invalid_submission.errors[:student_id]
        assert_not_empty invalid_submission.errors[:assignment_id]
        assert_not_empty invalid_submission.errors[:submitted_on]
        assert_not_empty invalid_submission.errors[:url]
        assert_equal 'pending', invalid_submission.submission_status
    end

    test "submission_status should be either 'pending', 'submitted', or 'late'" do
        valid_submission = Submission.new(
            student_id: @student.id,
            assignment_id: @assignment.id,
            submitted_on: Date.today,
            url: "http://example.com",
        )
        
        valid_statuses = ['pending', 'submitted', 'late']

        valid_statuses.each do |status|
            valid_submission.submission_status = status
            assert valid_submission.valid?
        end
    end

    test "submission_status should be 'late' if submitted_on is after assignment's due_date" do
        valid_submission = Submission.new(
            student_id: @student.id,
            assignment_id: @assignment.id,
            submitted_on: Date.today,
            url: "http://example.com",
        )

        valid_submission.submitted_on = @assignment.due_date + 1.day
        valid_submission.save

        assert_equal 'late', valid_submission.submission_status
    end

    test "submission_status should be 'submitted' if submitted_on is before or equal to assignment's due_date" do
        valid_submission = Submission.new(
            student_id: @student.id,
            assignment_id: @assignment.id,
            submitted_on: Date.today,
            url: "http://example.com",
        )

        valid_submission.submitted_on = @assignment.due_date - 1.day
        valid_submission.save
        assert_equal 'submitted', valid_submission.submission_status

        valid_submission.submitted_on = @assignment.due_date
        valid_submission.save
        assert_equal 'submitted', valid_submission.submission_status
    end
end
