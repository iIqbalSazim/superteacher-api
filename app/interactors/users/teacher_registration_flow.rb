class Users::TeacherRegistrationFlow
  include Interactor::Organizer

    organize Users::CreateNewUser,
             Users::CreateTeacherProfile,
             Users::GenerateAccessToken
end
