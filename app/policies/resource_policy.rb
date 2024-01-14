class ResourcePolicy < ApplicationPolicy
  def create_resource?
    user.role == "teacher"
  end
end
