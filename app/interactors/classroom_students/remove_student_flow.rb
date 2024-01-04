class ClassroomStudents::RemoveStudentFlow
    include Interactor::Organizer

    organize ClassroomStudents::FindStudent,
             ClassroomStudents::FindClassroom,
             ClassroomStudents::RemoveStudent
end
