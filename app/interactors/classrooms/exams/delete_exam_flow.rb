class Classrooms::Exams::DeleteExamFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             Shared::ValidateClassroomTeacher,
             Classrooms::Exams::DeleteExam
end
