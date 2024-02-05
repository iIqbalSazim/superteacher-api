require "test_helper"

class Resources::CreateNewResourceFlowTest < ActiveSupport::TestCase
  test "call all required interactors" do
    assert_equal Resources::CreateNewResourceFlow.organized, [
        Shared::FindClassroom,
        Shared::ValidateClassroomTeacher,
        Resources::CreateNewResource,
        Resources::MailEnrolledStudents
    ]
  end
end