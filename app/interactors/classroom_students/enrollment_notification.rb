class ClassroomStudents::EnrollmentNotification
  include Interactor

  def call
    student = context.student
    classroom = context.classroom

    if student && classroom
      ClassroomStudentMailer.with(student: student, classroom: classroom).enroll_student_email.deliver_later
    end
  end
end
