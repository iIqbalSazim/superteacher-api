class ClassroomStudents::RemoveStudentFlow
    include Interactor::Organizer

    organize ClassroomStudents::FindStudent,
             Classrooms::FindClassroom,
             ClassroomStudents::RemoveStudent
end
