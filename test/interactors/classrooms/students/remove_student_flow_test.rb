require "test_helper"

class Classrooms::Students::RemoveStudentFlowTest < ActiveSupport::TestCase
    test "#call all required interactors" do
        assert_equal Classrooms::Students::RemoveStudentFlow.organized, [
            Shared::FindClassroom,
            Shared::ValidateUserAccess,
            Classrooms::Students::RemoveStudent
        ]
    end
end