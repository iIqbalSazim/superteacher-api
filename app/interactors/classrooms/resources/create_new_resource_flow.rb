class Classrooms::Resources::CreateNewResourceFlow
  include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             Classrooms::Resources::CreateNewResource,
             Classrooms::Resources::MailEnrolledStudents
end
