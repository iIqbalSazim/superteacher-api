class Classrooms::Students::GetStudents < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[classroom filter].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        if filter == User::UNENROLLED_STUDENT
            fetch_unenrolled_students
        else
            fetch_enrolled_students
        end
    end

    def fetch_enrolled_students
        context.students = User.where(role: "student").where(id: classroom.student_ids)
    end

    def fetch_unenrolled_students
        context.students = User.where(role: "student").where.not(id: classroom.student_ids)
    end
end