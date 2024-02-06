class ClassroomStudents::EnrollStudentFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             ClassroomStudents::EnrollStudent,
             ClassroomStudents::EnrollmentNotification
end
