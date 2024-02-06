class Classrooms::Resources::GetResourcesFlow
    include Interactor::Organizer

    organize Shared::ValidateUserAccess,
             Classrooms::Resources::GetResources
end
