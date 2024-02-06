class ClassroomGlobalMessages::CreateMessageFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             ClassroomGlobalMessages::ValidateUserAccess,
             ClassroomGlobalMessages::CreateMessage,
             ClassroomGlobalMessages::BroadcastMessage
end
