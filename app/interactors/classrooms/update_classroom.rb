class Classrooms::UpdateClassroom
    include Interactor

    REQUIRED_PARAMS = %i[classroom_params classroom].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
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
