class Classrooms::UpdateClassroom < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[classroom_params classroom].freeze

    CLASSROOM_FAILED_TO_UPDATE = "Classroom failed to update"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        update_classroom
    end

    private

    def update_classroom
        updated_classroom = ClassroomRepository.update(classroom, classroom_params)
        if updated_classroom.valid?
            context.updated_classroom = classroom
        else
            context.fail!(
                message: CLASSROOM_FAILED_TO_UPDATE,
                status: :unprocessable_entity
            )
        end
    end
end