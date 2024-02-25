class Classrooms::Assignments::SubmissionPolicy < ApplicationPolicy

  def index?
    user.teacher?
  end

  def create?
    user.student?
  end

  def destroy?
    user.student?
  end
end
