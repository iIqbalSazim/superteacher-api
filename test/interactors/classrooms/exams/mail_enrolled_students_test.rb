require 'test_helper'

class Classrooms::Exams::MailEnrolledStudentsTest < ActiveSupport::TestCase

    test "should send email to all enrolled students" do
        classroom = classrooms(:math_classroom)
        exam = exams(:math_exam_one)

        student_emails = ["student1@example.com", "student2@example.com"]

        classroom.students.each_with_index do |student, index|
            student.stubs(:email).returns(student_emails[index])
        end

        ExamMailer.expects(:with).times(student_emails.length).returns(ExamMailer)
        ExamMailer.expects(:create_exam_email).times(student_emails.length).returns(ExamMailer)
        ExamMailer.expects(:deliver_later).times(student_emails.length)

        result = Classrooms::Exams::MailEnrolledStudents.call(exam: exam, classroom: classroom)

        assert result.success?
    end
end
