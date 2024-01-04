class Classrooms::GetClassroomsStudent
  include Interactor

    def call
        user_id = context.user_id 

        all_classrooms = Classroom.where(id: ClassroomStudent.where(student_id: user_id).pluck(:classroom_id))

        if all_classrooms.present?
            context.classrooms = all_classrooms
        else
            context.fail!(
                error: "Classrooms not found",
            )
        end
    end
end
