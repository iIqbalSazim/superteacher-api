class Classrooms::Students::GetStudents < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[classroom filter].freeze

    STUDENTS_NOT_FOUND = "Students not found"
    ENROLLED_NOT_FOUND = "No enrolled students found"

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        validate_params REQUIRED_PARAMS

        if filter == "unenrolled"
            fetch_unenrolled_students
        else
            fetch_enrolled_students
        end
    end

    private

    def fetch_enrolled_students
        context.students = classroom.students
     end

    def fetch_unenrolled_students
        unenrolled_students = User.where(role: "student").where.not(id: classroom.student_ids)

        context.students = unenrolled_students
    end
end