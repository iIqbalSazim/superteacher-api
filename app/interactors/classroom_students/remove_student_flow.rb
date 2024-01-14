class ClassroomStudents::RemoveStudentFlow
    include Interactor::Organizer

    organize ClassroomStudents::FindStudent,
             Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             ClassroomStudents::RemoveStudent
end
