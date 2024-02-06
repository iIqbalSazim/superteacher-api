class Classrooms::Students::GetStudentsFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateUserAccess,
             Classrooms::Students::GetStudents
end
