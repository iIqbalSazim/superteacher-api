class Classrooms::Assignments::SubmissionPolicy < ApplicationPolicy

  def create?
    user.student?
  end

  def destroy?
    user.student?
  end
end
