require "test_helper"

class Classrooms::Resources::UpdateResourceFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Classrooms::Resources::UpdateResourceFlow.organized, [
      Shared::FindClassroom,
      Shared::ValidateUserAccess,
      Classrooms::Resources::UpdateResource
    ]
  end
end