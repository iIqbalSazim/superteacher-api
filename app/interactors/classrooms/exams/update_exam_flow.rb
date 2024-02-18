class Classrooms::Exams::UpdateExamFlow
  include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             Classrooms::Exams::UpdateExam
end
