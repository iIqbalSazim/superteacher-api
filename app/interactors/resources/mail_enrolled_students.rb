class Resources::MailEnrolledStudents
    include Interactor

    REQUIRED_PARAMS = %i[resource classroom].freeze

    delegate(*REQUIRED_PARAMS, to: :context)

    def call
        if resource && classroom
            classroom.students.each do |student|
                ResourceMailer.with(resource: resource, student_email: student.email, classroom: classroom).create_resource_email.deliver_later
            end
        end
    end
end