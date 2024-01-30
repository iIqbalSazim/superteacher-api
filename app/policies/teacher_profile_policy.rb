class TeacherProfilePolicy < ApplicationPolicy
    def update_teacher_profile?
        user.role == "teacher"
    end
end
