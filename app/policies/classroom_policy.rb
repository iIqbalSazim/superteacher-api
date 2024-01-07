class ClassroomPolicy < ApplicationPolicy
  def create_classroom?
    user.role == "teacher"
  end

  def update_classroom?
    user.role == "teacher" && record.teacher_id == user.id
  end

  def delete_classroom?
    user.role == "teacher" && record.teacher_id == user.id
  end
end
