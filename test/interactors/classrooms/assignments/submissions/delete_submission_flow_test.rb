require "test_helper"

class Classrooms::Assignments::Submissions::DeleteSubmissionFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Classrooms::Assignments::Submissions::DeleteSubmissionFlow.organized, [
      Shared::ValidateUserAccess,
      Classrooms::Assignments::Submissions::DeleteSubmission
    ]
  end
end