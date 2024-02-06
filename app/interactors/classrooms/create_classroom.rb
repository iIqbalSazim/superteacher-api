class Classrooms::CreateClassroom < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[classroom_params].freeze

    FAILED_TO_CREATE = "Failed to create classroom"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        new_classroom = Classroom.new(classroom_params)

        save_classroom(new_classroom)
    end

    private

    def save_classroom(new_classroom)
        if new_classroom.save
            context.new_classroom = new_classroom
        else
            context.fail!(
                message: FAILED_TO_CREATE
            )
        end
    end
end
