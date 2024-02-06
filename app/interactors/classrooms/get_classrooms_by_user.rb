class Classrooms::GetClassroomsByUser
    include Interactor

    def call
        user_id = context.user_id

        if context.user_role == "teacher"
            all_classrooms = Classroom.where(teacher_id: user_id)
        elsif context.user_role == "student"
            all_classrooms = Classroom.where(id: ClassroomStudent.where(student_id: user_id).pluck(:classroom_id))
        end

        if all_classrooms.present?
            context.classrooms = all_classrooms
        else
            context.fail!(
                error: "Classrooms not found"
            )
        end
    end
end
