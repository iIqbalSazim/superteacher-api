require 'test_helper'

class Classrooms::Students::EnrollmentNotificationTest < ActiveSupport::TestCase

    test "should send enrollment notification email to student" do
        classroom = build(:classroom) 
        student = build(:user, :student)  

        ClassroomStudentMailer.expects(:with).with(student: student, classroom: classroom).returns(ClassroomStudentMailer)
        ClassroomStudentMailer.expects(:enroll_student_email).returns(ClassroomStudentMailer)
        ClassroomStudentMailer.expects(:deliver_later)

        result = Classrooms::Students::EnrollmentNotification.call(student: student, classroom: classroom)

        assert result.success?
    end
end