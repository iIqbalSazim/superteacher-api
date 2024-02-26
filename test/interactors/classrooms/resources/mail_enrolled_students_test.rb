require 'test_helper'

class Classrooms::Resources::MailEnrolledStudentsTest < ActiveSupport::TestCase

    test "should send email to all enrolled students" do
        classroom = classrooms(:math_classroom)
        resource = resources(:math_resource_one)

        student_emails = ["student1@example.com", "student2@example.com"]

        classroom.students.each_with_index do |student, index|
            student.stubs(:email).returns(student_emails[index])
        end

        ResourceMailer.expects(:with).times(student_emails.length).returns(ResourceMailer)
        ResourceMailer.expects(:create_resource_email).times(student_emails.length).returns(ResourceMailer)
        ResourceMailer.expects(:deliver_later).times(student_emails.length)

        result = Classrooms::Resources::MailEnrolledStudents.call(resource: resource, classroom: classroom)

        assert result.success?
    end
end
