class ClassroomStudents::GetEnrolledStudents
  include Interactor

    def call
        classroom_id = context.classroom_id

        students = Classroom.find_by(id: classroom_id).students

        if students.present?
            context.enrolled_students = students
        else
            context.fail!(
                error: "Students not found",
                message: "No students found for the specified IDs in the user table",
                status: :unprocessable_entity
            )
        end
    end
end
