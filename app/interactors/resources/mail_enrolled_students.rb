class Resources::MailEnrolledStudents
    include Interactor

    def call
        resource = context.resource
        classroom = context.classroom
        enrolled_students = context.enrolled_students
        teacher = context.teacher

        all_student_ids = ClassroomStudent.where(classroom_id: classroom.id).pluck(:student_id)

        if all_student_ids.present?
            student_emails = User.where(id: all_student_ids, role: "student").pluck(:email)
        end

        ResourceMailer.with(teacher: teacher, resource: resource, student_emails: student_emails, classroom: classroom).create_resource_email.deliver_later
    end
end