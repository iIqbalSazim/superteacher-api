class Classrooms::GetClassroomsByUser < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[current_user].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        all_classrooms = fetch_classrooms

        context.classrooms = all_classrooms
    end

    private

    def fetch_classrooms
        if current_user.teacher?
            Classroom.where(teacher_id: current_user.id)
        else
            Classroom.left_outer_joins(:classroom_students).where(classroom_students: { student_id: current_user.id })
        end
    end
end