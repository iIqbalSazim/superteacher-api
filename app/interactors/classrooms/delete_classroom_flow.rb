class Classrooms::DeleteClassroomFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateUserAccess,
             Classrooms::DeleteClassroom
end
