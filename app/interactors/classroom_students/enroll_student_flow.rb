class ClassroomStudents::EnrollStudentFlow
    include Interactor::Organizer

    organize ClassroomStudents::FindStudent,
             ClassroomStudents::FindClassroom,
             ClassroomStudents::EnrollStudent
end
