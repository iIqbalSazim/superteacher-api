class Classrooms::UpdateClassroom
  include Interactor

    def call
        classroom_params = context.classroom_params
        classroom = context.classroom

        if classroom.update(classroom_params)
            context.updated_classroom = classroom
        else
            context.fail!(
                error: "Something went wrong!",
                message: "Classroom failed to update.",
                status: :internal_server_error
            )
        end
    end
end
