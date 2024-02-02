class Resources::MailEnrolledStudents
    include Interactor

    REQUIRED_PARAMS = %i[resource classroom enrolled_students teacher].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        all_students = classroom.students

        if all_students && resource && classroom
            all_students.each do |student|
                ResourceMailer.with(resource: resource, student_email: student.email, classroom: classroom).create_resource_email.deliver_later
            end
        end
    end
end