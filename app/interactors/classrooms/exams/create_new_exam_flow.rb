class Classrooms::Exams::CreateNewExamFlow
  include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             Classrooms::Exams::CreateNewExam,
             Classrooms::Exams::MailEnrolledStudents
end
