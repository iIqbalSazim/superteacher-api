class Classrooms::ResourcePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.teacher?
  end
end
