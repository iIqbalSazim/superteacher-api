require "test_helper"

class Resources::CreateNewResourceFlowTest < ActiveSupport::TestCase
  test "call all required interactors" do
    assert_equal Resources::CreateNewResourceFlow.organized, [
        Resources::CreateNewResource,
        Resources::FindTeacher,
        Shared::FindClassroom,
        Shared::ValidateClassroomTeacher,
        Resources::MailEnrolledStudents
    ]
  end
end