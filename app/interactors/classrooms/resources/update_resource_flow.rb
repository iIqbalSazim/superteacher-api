class Classrooms::Resources::UpdateResourceFlow
  include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             Classrooms::Resources::UpdateResource
end
