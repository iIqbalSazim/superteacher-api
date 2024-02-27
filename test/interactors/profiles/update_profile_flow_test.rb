require "test_helper"

class Profiles::UpdateProfileFlowTest < ActiveSupport::TestCase
  test "#call all required interactors" do
    assert_equal Profiles::UpdateProfileFlow.organized, [
      Profiles::UpdateUserDetails,
      Profiles::UpdateProfile
    ]
  end
end