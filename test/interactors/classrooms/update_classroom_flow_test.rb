require "test_helper"

class Classrooms::UpdateClassroomFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Classrooms::UpdateClassroomFlow.organized, [
      Shared::FindClassroom,
      Shared::ValidateUserAccess,
      Classrooms::UpdateClassroom
    ]
  end
end