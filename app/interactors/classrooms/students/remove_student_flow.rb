class Classrooms::Students::RemoveStudentFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             Classrooms::Students::RemoveStudent
end
