class Classrooms::Students::EnrollStudentFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             Classrooms::Students::EnrollStudent,
             Classrooms::Students::EnrollmentNotification
end
