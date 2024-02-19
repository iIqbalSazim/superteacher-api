class Classrooms::Resources::UpdateResourceFlow
  include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateUserAccess,
             Classrooms::Resources::UpdateResource
end
