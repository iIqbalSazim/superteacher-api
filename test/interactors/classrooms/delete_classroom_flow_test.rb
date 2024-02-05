require "test_helper"

class Classrooms::DeleteClassroomFlowTest < ActiveSupport::TestCase
  test "call all required interactors" do
    assert_equal Classrooms::DeleteClassroomFlow.organized, [
        Shared::FindClassroom,
        Shared::ValidateClassroomTeacher,
        Classrooms::DeleteClassroom
    ]
  end
end