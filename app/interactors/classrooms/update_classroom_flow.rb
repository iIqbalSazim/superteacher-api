class Classrooms::UpdateClassroomFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             Classrooms::UpdateClassroom
end
