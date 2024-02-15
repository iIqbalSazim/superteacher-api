class Classrooms::ExamPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.teacher?
  end
end
