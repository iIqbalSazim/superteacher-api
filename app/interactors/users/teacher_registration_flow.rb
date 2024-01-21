class Users::TeacherRegistrationFlow
  include Interactor::Organizer

    organize Users::ValidateRegistrationCode,
             Users::CreateNewUser,
             Users::CreateTeacherProfile,
             Users::GenerateAccessToken
end
