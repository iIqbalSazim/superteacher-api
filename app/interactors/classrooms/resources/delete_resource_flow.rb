class Classrooms::Resources::DeleteResourceFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateUserAccess,
             Classrooms::Resources::DeleteResource
end
