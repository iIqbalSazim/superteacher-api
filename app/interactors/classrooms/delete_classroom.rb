class Classrooms::DeleteClassroom < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[classroom].freeze

    CLASSROOM_DELETE_FAILED = "Failed to delete classroom"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        context.fail!(
            message: CLASSROOM_DELETE_FAILED,
            status: :unprocessable_entity
        ) unless ClassroomRepository.destroy(classroom)
    end
end
