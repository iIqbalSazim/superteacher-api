class ClassroomStudentPolicy < ApplicationPolicy
  def enroll_student?
    user.role == "teacher" && user_teacher_of_classroom?
  end

  def remove_student?
    user.role == "teacher" && user_teacher_of_classroom?
  end
end
