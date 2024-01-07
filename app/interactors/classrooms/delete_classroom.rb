class Classrooms::DeleteClassroom
    include Interactor

    def call
        classroom = context.classroom

        if classroom
            classroom.destroy
        else
            context.fail!(
                error: "Classroom not found",
                message: "Classroom with given ID not found.",
                status: :not_found
            )
        end
    end
end
