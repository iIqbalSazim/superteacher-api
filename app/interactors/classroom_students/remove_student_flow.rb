class ClassroomStudents::RemoveStudentFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             ClassroomStudents::RemoveStudent
end
