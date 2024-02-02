class Resources::CreateNewResourceFlow
  include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             Resources::CreateNewResource,
             Resources::MailEnrolledStudents
end
