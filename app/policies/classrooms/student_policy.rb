class Classrooms::StudentPolicy < ApplicationPolicy
  def index?
    true
  end

  def unenrolled_students?
    user.teacher?
  end

  def enroll?
    user.teacher?
  end

  def remove?
    user.teacher? 
  end
end
