require "test_helper"

class Classrooms::Exams::CreateNewExamFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Classrooms::Exams::CreateNewExamFlow.organized, [
      Shared::FindClassroom,
      Shared::ValidateUserAccess,
      Classrooms::Exams::CreateNewExam,
      Classrooms::Exams::MailEnrolledStudents
    ]
  end
end