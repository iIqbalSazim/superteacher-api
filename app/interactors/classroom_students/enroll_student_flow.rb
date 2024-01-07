class ClassroomStudents::EnrollStudentFlow
    include Interactor::Organizer

    organize ClassroomStudents::FindStudent,
             Classrooms::FindClassroom,
             ClassroomStudents::EnrollStudent
end
