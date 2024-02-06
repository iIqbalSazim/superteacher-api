class Classrooms::GlobalMessages::GetMessagesFlow
    include Interactor::Organizer

    organize Shared::ValidateUserAccess,
             Classrooms::GlobalMessages::GetMessages
end
