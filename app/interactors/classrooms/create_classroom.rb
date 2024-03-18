class Classrooms::CreateClassroom < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[classroom_params].freeze

    FAILED_TO_CREATE = "Failed to create classroom"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        new_classroom = ClassroomRepository.create(classroom_params)

        if new_classroom.valid?
            context.new_classroom = new_classroom
        else
            context.fail!(
                message: FAILED_TO_CREATE
            )
        end
    end
end
