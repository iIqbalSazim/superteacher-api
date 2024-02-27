require "test_helper"

class Classrooms::Assignments::Submissions::GetSubmissionsFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Classrooms::Assignments::Submissions::GetSubmissionsFlow.organized, [
      Shared::ValidateUserAccess,
      Classrooms::Assignments::Submissions::GetSubmissions
    ]
  end
end