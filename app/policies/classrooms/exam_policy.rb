class Classrooms::ExamPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.teacher?
  end

  def update?
    user.teacher?
  end


  def destroy?
    user.teacher?
  end
end
