require 'test_helper'

class Classrooms::Exams::MailEnrolledStudentsTest < ActiveSupport::TestCase

    test "should send email to all enrolled students" do
        classroom = create(:classroom)
        exam = create(:exam, classroom: classroom)

        student_emails = ["student1@example.com", "student2@example.com"]

        enrolled_students = [
            create(:user, :math_student, email: student_emails[0]),
            create(:user, :math_student_two, email: student_emails[1])
        ]

        classroom.students << enrolled_students

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
