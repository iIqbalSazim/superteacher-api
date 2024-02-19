class Classrooms::UpdateClassroomFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateUserAccess,
             Classrooms::UpdateClassroom
end
