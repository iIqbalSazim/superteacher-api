class StudentProfiles::GetStudentProfile
    include Interactor

    def call
        student_id = context.id

        if student = StudentProfile.find_by(student_id: student_id)
            context.student = student
        else
            context.fail!(
                error: "Student not found",
                message: "Student does not exist in the database",
                status: :unprocessable_entity
            )
        end
    end
end
