class Resources::CreateNewResourceFlow
  include Interactor::Organizer

    organize Resources::CreateNewResource,
             Resources::FindTeacher,
             Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             Resources::MailEnrolledStudents
end
