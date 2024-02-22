require "test_helper"

class Classrooms::Students::EnrollStudentFlowTest < ActiveSupport::TestCase
    test "#call all required interactors" do
        assert_equal Classrooms::Students::EnrollStudentFlow.organized, [
            Shared::FindClassroom,
            Shared::ValidateUserAccess,
            Classrooms::Students::EnrollStudent,
            Classrooms::Students::EnrollmentNotification,
        ]
    end
end