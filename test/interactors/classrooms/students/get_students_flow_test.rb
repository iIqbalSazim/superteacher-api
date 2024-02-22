require "test_helper"

class Classrooms::Students::GetStudentsFlowTest < ActiveSupport::TestCase
    test "#call all required interactors" do
        assert_equal Classrooms::Students::GetStudentsFlow.organized, [
            Shared::FindClassroom,
            Shared::ValidateUserAccess,
            Classrooms::Students::GetStudents
        ]
    end
end