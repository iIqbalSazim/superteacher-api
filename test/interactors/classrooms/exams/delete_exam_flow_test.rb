require "test_helper"

class Classrooms::Exams::DeleteExamFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Classrooms::Exams::DeleteExamFlow.organized, [
      Shared::FindClassroom,
      Shared::ValidateUserAccess,
      Classrooms::Exams::DeleteExam
    ]
  end
end