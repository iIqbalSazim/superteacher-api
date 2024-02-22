require "test_helper"

class Classrooms::GlobalMessages::CreateMessageFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Classrooms::GlobalMessages::CreateMessageFlow.organized, [
      Shared::FindClassroom,
      Shared::ValidateUserAccess,
      Classrooms::GlobalMessages::CreateMessage,
      Classrooms::GlobalMessages::BroadcastMessage
    ]
  end
end