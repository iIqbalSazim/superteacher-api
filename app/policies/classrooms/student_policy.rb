class Classrooms::StudentPolicy < ApplicationPolicy
  def index?
    true
  end

  def enroll?
    user.teacher?
  end

  def remove?
    user.teacher? 
  end
end
