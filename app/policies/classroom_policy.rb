class ClassroomPolicy < ApplicationPolicy
  def create_classroom?
    user.role == "teacher"
  end
end
