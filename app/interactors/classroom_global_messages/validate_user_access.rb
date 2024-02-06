class ClassroomGlobalMessages::ValidateUserAccess
    include Interactor

    REQUIRED_PARAMS = %i[current_user classroom].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_teacher_access if current_user.role == "teacher"
        validate_student_access if current_user.role == "student"
    end

    private

    def validate_teacher_access
        unless classroom.teacher_id == current_user.id
            unauthorized_access
        end
    end

    def validate_student_access
        unless classroom.student_ids.include?(current_user.id)
            unauthorized_access
        end
    end

    def unauthorized_access
        context.fail!(
            error: "Unauthorized",
            message: "You are not authorized",
            status: :forbidden
        )
    end
end
