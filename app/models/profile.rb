class Profile < ApplicationRecord
    self.abstract_class = true
    belongs_to :user, polymorphic: true

    def user 
        case self.class.name
            when "TeacherProfile" then self.teacher
            when "StudentProfile" then self.student
        end
    end
end 