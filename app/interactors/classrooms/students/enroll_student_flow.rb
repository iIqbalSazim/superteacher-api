class Classrooms::Students::EnrollStudentFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateUserAccess,
             Classrooms::Students::EnrollStudent,
             Classrooms::Students::EnrollmentNotification
end
