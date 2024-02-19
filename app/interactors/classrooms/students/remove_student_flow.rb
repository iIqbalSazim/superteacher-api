class Classrooms::Students::RemoveStudentFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateUserAccess,
             Classrooms::Students::RemoveStudent
end
