class Classrooms::DeleteClassroomFlow
    include Interactor::Organizer

    organize Classrooms::FindClassroom,
             Classrooms::DeleteClassroom
end
