class Users::UserRegistrationFlow
    include Interactor::Organizer

    organize Users::ValidateRegistrationCode,
             Users::CreateNewUser,
             Users::CreateUserProfile,
             Users::GenerateAccessToken
end
