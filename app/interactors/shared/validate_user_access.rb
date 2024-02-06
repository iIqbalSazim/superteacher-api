class Shared::ValidateUserAccess < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[current_user classroom_id].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        classroom = Classroom.find(classroom_id)

        validate_teacher_access(classroom) if current_user.teacher?
        validate_student_access(classroom) if current_user.student?
    end

    private

    def validate_teacher_access(classroom)
        unless classroom.teacher_id == current_user.id
            handle_unauthorized_access
        end
    end

    def validate_student_access(classroom)
        unless classroom.student_ids.include?(current_user.id)
            handle_unauthorized_access
        end
    end

    def handle_unauthorized_access
        context.fail!(
            message: YOU_ARE_NOT_AUTHORIZED,
        )
    end
end