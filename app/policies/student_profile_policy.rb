class StudentProfilePolicy < ApplicationPolicy
    def get_student_profile?
        user.role == "student"
    end

    def update_student_profile?
        user.role == "student"
    end
end
