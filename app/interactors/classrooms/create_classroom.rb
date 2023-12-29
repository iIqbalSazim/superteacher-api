class Classrooms::CreateClassroom
  include Interactor

  def call
        classroom_params = context.classroom_params

        classroom_params[:teacher_id] = context.teacher_id

        new_classroom = Classroom.new(
            classroom_params
        )

        if new_classroom.save
            context.new_classroom = new_classroom
        else
            context.fail!(
                error: "Something went wrong!",
                message: "Classroom failed to save.",
                status: :internal_server_error
            )
        end
    end
end
