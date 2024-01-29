class ClassroomStudents::EnrollStudentFlow
    include Interactor::Organizer

    organize ClassroomStudents::FindStudent,
             Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             ClassroomStudents::EnrollStudent,
             ClassroomStudents::EnrollmentNotification
end
