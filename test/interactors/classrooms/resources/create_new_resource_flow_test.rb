require "test_helper"

class Classrooms::Resources::CreateNewResourceFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Classrooms::Resources::CreateNewResourceFlow.organized, [
      Shared::FindClassroom,
      Shared::ValidateUserAccess,
      Classrooms::Resources::CreateNewResource,
      Classrooms::Resources::MailEnrolledStudents
    ]
  end
end