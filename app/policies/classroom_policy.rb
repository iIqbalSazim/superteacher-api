class ClassroomPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.role == "teacher"
  end

  def update?
    user.role == "teacher" 
  end

  def destroy?
    user.role == "teacher" 
  end
end
