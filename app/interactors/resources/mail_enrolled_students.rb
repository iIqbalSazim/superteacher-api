class Resources::MailEnrolledStudents
    include Interactor

    def call
        resource = context.resource
        classroom = context.classroom
        enrolled_students = context.enrolled_students
        teacher = context.teacher

        student_emails = enrolled_students.pluck(:email)

        ResourceMailer.with(teacher: teacher, resource: resource, student_emails: student_emails, classroom: classroom).create_resource_email.deliver_later
    end
end