require "test_helper"

class Users::UserRegistrationFlowTest < ActiveSupport::TestCase
    test "#call all required interactors" do
        assert_equal Users::UserRegistrationFlow.organized, [
            Users::ValidateRegistrationCode,
            Users::CreateNewUser,
            Users::CreateUserProfile
        ]
    end
end