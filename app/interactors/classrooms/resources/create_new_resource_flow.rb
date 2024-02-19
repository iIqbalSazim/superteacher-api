class Classrooms::Resources::CreateNewResourceFlow
  include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateUserAccess,
             Classrooms::Resources::CreateNewResource,
             Classrooms::Resources::MailEnrolledStudents
end
