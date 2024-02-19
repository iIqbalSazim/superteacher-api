class Classrooms::Exams::UpdateExamFlow
  include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateUserAccess,
             Classrooms::Exams::UpdateExam
end
