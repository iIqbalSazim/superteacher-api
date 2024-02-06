class Classrooms::GlobalMessages::CreateMessageFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateUserAccess,
             Classrooms::GlobalMessages::CreateMessage,
             Classrooms::GlobalMessages::BroadcastMessage
end
