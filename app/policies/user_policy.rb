class UserPolicy < ApplicationPolicy
  def get_unenrolled_students?
    user.role == "teacher"
  end
end
