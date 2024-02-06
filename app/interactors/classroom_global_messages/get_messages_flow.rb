class ClassroomGlobalMessages::GetMessagesFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             ClassroomGlobalMessages::ValidateUserAccess,
             ClassroomGlobalMessages::GetMessages
end
