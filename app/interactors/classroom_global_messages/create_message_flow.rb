class ClassroomGlobalMessages::CreateMessageFlow
    include Interactor::Organizer

    organize ClassroomGlobalMessages::CreateMessage,
             ClassroomGlobalMessages::BroadcastMessage
end
