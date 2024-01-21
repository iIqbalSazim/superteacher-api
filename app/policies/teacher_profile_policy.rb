class TeacherProfilePolicy < ApplicationPolicy
    def get_teacher_profile?
        user.role == "teacher"
    end

    def update_teacher_profile?
        user.role == "teacher"
    end
end
