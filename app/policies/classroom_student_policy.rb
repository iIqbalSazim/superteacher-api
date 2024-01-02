class ClassroomStudentPolicy < ApplicationPolicy
  def enroll_student?
    user.role == "teacher"
  end
end
