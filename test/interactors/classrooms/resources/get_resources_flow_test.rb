require "test_helper"

class Classrooms::Resources::GetResourcesFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Classrooms::Resources::GetResourcesFlow.organized, [
      Shared::ValidateUserAccess,
      Classrooms::Resources::GetResources
    ]
  end
end