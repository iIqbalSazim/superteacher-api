class StudentProfilePolicy < ApplicationPolicy
    def update?
        user.role == "student"
    end
end
