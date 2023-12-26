class Users::StudentRegistrationFlow
    include Interactor::Organizer

    organize Users::CreateNewUser,
             Users::CreateStudentProfile,
             Users::GenerateAccessToken
end
