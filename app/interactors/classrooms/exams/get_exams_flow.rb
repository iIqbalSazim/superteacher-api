class Classrooms::Exams::GetExamsFlow
    include Interactor::Organizer

    organize Shared::ValidateUserAccess,
             Classrooms::Exams::GetExams
end
