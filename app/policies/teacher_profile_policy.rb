class TeacherProfilePolicy < ApplicationPolicy
    def update?
        user.role == "teacher"
    end
end
