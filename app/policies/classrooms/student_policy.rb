class Classrooms::StudentPolicy < ApplicationPolicy
  def index?
    true
  end

  def unenrolled_students?
    user.role == "teacher"
  end

  def enroll?
    user.role == "teacher"
  end

  def remove?
    user.role == "teacher" 
  end
end
