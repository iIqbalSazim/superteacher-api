class TeacherProfiles::GetTeacherProfile
    include Interactor

    def call
        teacher_id = context.id

        if teacher = TeacherProfile.find_by(teacher_id: teacher_id)
            context.teacher = teacher
        else
            context.fail!(
                error: "Teacher not found",
                message: "Teacher does not exist in the database",
                status: :unprocessable_entity
            )
        end
    end
end
