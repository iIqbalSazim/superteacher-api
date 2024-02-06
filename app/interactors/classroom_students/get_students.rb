class ClassroomStudents::GetStudents
    include Interactor

    REQUIRED_PARAMS = %i[classroom filter].freeze

    STUDENTS_NOT_FOUND = "Students not found"
    ENROLLED_NOT_FOUND = "No enrolled students found"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        case filter
        when "enrolled"
            fetch_enrolled_students
        when "unenrolled"
            fetch_unenrolled_students
        end
    end

    private

    def fetch_enrolled_students
        if classroom.students.present?
            context.students = classroom.students
        else
            handle_enrolled_not_found
        end
    end

    def fetch_unenrolled_students
        unenrolled_students = User.where(role: "student").where.not(id: classroom.student_ids)

        if unenrolled_students.present?
            context.students = unenrolled_students
        else
            handle_unenrolled_not_found
        end
    end

    def handle_enrolled_not_found
        context.fail!(
            error: STUDENTS_NOT_FOUND,
            message: ENROLLED_NOT_FOUND,
            status: :unprocessable_entity
        )
    end

    def handle_unenrolled_not_found
        context.fail!(
            error: STUDENTS_NOT_FOUND,
            status: :unprocessable_entity
        )
    end
end