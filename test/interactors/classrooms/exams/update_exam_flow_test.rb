require "test_helper"

class Classrooms::Exams::UpdateExamFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Classrooms::Exams::UpdateExamFlow.organized, [
      Shared::FindClassroom,
      Shared::ValidateUserAccess,
      Classrooms::Exams::UpdateExam
    ]
  end
end