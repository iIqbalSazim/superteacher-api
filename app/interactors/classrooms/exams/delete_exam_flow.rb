class Classrooms::Exams::DeleteExamFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateUserAccess,
             Classrooms::Exams::DeleteExam
end
