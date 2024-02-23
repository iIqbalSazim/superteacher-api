require "test_helper"

class Classrooms::Exams::GetExamsFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Classrooms::Exams::GetExamsFlow.organized, [
      Shared::ValidateUserAccess,
      Classrooms::Exams::GetExams
    ]
  end
end