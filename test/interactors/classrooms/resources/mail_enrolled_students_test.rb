require 'test_helper'

class Classrooms::Resources::MailEnrolledStudentsTest < ActiveSupport::TestCase

    test "should send email to all enrolled students" do
        classroom = create(:classroom)
        resource = create(:resource, :assignment_resource, classroom: classroom)

        student_emails = ["student1@example.com", "student2@example.com"]

        enrolled_students = [
            create(:user, :math_student, email: student_emails[0]),
            create(:user, :math_student_two, email: student_emails[1])
        ]

        classroom.students << enrolled_students

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
