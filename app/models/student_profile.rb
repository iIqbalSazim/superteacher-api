class StudentProfile < ApplicationRecord
    belongs_to :user, foreign_key: 'student_id'

    validates :education, presence: true
    validates :address, presence: true
end
