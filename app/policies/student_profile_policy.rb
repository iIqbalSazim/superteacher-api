class StudentProfilePolicy < ApplicationPolicy
    def update_student_profile?
        user.role == "student"
    end
end
