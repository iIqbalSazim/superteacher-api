class TeacherProfile < ApplicationRecord
    belongs_to :user, foreign_key: 'teacher_id'
end
