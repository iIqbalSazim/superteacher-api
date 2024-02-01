class Resources::MailEnrolledStudents
    include Interactor

    REQUIRED_PARAMS = %i[resource classroom enrolled_students teacher].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        all_student_ids = ClassroomStudent.where(classroom_id: classroom.id).pluck(:student_id)

        if all_student_ids.present?
            student_emails = User.where(id: all_student_ids, role: "student").pluck(:email)
            ResourceMailer.with(teacher: teacher, resource: resource, student_emails: student_emails, classroom: classroom).create_resource_email.deliver_later
        end
    end
end