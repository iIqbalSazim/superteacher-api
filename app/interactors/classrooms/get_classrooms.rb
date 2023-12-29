class Classrooms::GetClassrooms
  include Interactor

  def call
        user_id = context.user_id 

        all_classrooms = Classroom.where(teacher_id: user_id)

        if all_classrooms.present?
            context.classrooms = all_classrooms
        else
            context.fail!(
                error: "Classrooms not found",
                message: "No classrooms found for the specified teacher_id",
            )
        end
    end
end
