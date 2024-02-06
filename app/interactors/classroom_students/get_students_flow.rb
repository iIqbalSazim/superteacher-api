class ClassroomStudents::GetStudentsFlow
    include Interactor::Organizer

    organize Shared::FindClassroom,
             ClassroomStudents::GetStudents
end
