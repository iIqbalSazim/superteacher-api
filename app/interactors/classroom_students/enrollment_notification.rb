class ClassroomStudents::EnrollmentNotification
  include Interactor

  def call
    student = context.student
    classroom = context.classroom

    ClassroomStudentMailer.with(student: student, classroom: classroom).enroll_student_email.deliver_later
  end
end
