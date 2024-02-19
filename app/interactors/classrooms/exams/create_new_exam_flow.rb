class Classrooms::Exams::CreateNewExamFlow
  include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateUserAccess,
             Classrooms::Exams::CreateNewExam,
             Classrooms::Exams::MailEnrolledStudents
end
