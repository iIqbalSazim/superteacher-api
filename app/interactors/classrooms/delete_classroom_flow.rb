class Classrooms::DeleteClassroomFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             Classrooms::DeleteClassroom
end
