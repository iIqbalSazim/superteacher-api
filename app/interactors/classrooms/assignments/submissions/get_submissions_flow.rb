class Classrooms::Assignments::Submissions::GetSubmissionsFlow
    include Interactor::Organizer

    organize Shared::ValidateUserAccess,
             Classrooms::Assignments::Submissions::GetSubmissions
end
