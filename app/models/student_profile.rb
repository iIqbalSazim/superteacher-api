class StudentProfile < ApplicationRecord
    belongs_to :user, foreign_key: 'student_id'
end
