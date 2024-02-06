class Classrooms::Resources::MailEnrolledStudents < BaseInteractor
    include Interactor

    REQUIRED_PARAMS = %i[resource classroom].freeze

    delegate(*REQUIRED_PARAMS, to: :context)
  
    def call
        validate_params REQUIRED_PARAMS

        send_resource_email_to_enrolled_students
    end

    private

    def send_resource_email_to_enrolled_students
        classroom.students.each do |student|
            ResourceMailer.with(resource: resource, student_email: student.email, classroom: classroom).create_resource_email.deliver_later
        end
    end
end