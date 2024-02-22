require "test_helper"

class Classrooms::GlobalMessages::GetMessagesFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Classrooms::GlobalMessages::GetMessagesFlow.organized, [
      Shared::ValidateUserAccess,
      Classrooms::GlobalMessages::GetMessages
    ]
  end
end