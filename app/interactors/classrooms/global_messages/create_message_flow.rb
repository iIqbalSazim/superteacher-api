class Classrooms::GlobalMessages::CreateMessageFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Classrooms::GlobalMessages::ValidateUserAccess,
             Classrooms::GlobalMessages::CreateMessage,
             Classrooms::GlobalMessages::BroadcastMessage
end
