class Shared::ValidateUserAccess < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[current_user classroom_id].freeze

    CLASSROOM_NOT_FOUND = "Classroom not found"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        classroom = ClassroomRepository.find_by_id(classroom_id)

        if classroom.present?
            validate_teacher_access(classroom) if current_user.teacher?
            validate_student_access(classroom) if current_user.student?
        else
            context.fail!(
                message: CLASSROOM_NOT_FOUND,
                status: :unprocessable_entity
            )
        end
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
            status: :forbidden
        )
    end
end