class ClassroomStudents::GetStudents
  include Interactor

    def call
        classroom_id = context.classroom_id

        all_student_ids = ClassroomStudent.where(classroom_id: classroom_id).pluck(:student_id)

        if all_student_ids.present?
            students = User.where(id: all_student_ids)

            if students.present?
                context.students = students
            else
                context.fail!(
                    error: "Students not found",
                    message: "No students found for the specified IDs in the user table",
                    status: :unprocessable_entity
                )
            end
        else
            context.fail!(
                error: "Students not found",
                message: "No students found for the specified classroom_id",
                status: :unprocessable_entity
            )
        end
    end
end
