require "test_helper"

class Classrooms::Assignments::Submissions::CreateNewSubmissionFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Classrooms::Assignments::Submissions::CreateNewSubmissionFlow.organized, [
      Shared::ValidateUserAccess,
      Classrooms::Assignments::Submissions::CreateNewSubmission
    ]
  end
end