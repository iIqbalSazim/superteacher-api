require "test_helper"

class Classrooms::Resources::DeleteResourceFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Classrooms::Resources::DeleteResourceFlow.organized, [
      Shared::FindClassroom,
      Shared::ValidateUserAccess,
      Classrooms::Resources::DeleteResource
    ]
  end
end