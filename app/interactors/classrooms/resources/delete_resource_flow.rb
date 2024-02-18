class Classrooms::Resources::DeleteResourceFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             Classrooms::Resources::DeleteResource
end
