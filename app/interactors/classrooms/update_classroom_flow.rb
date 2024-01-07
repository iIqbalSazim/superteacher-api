class Classrooms::UpdateClassroomFlow
    include Interactor::Organizer

    organize Classrooms::FindClassroom,
             Classrooms::UpdateClassroom
end
