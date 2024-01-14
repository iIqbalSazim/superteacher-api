class StudentProfile < ApplicationRecord
    belongs_to :user, foreign_key: 'student_id'

    validates :education, presence: true, length: { maximum: 255 }
    validates :address, presence: true, length: { maximum: 1000 }
end
