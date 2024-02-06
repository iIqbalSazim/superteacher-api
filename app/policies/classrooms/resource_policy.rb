class Classrooms::ResourcePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.role == "teacher"
  end
end
