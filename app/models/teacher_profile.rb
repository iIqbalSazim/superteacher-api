class TeacherProfile < ApplicationRecord
    belongs_to :user, foreign_key: 'teacher_id'

    validates :highest_education_level, presence: true, length: { maximum: 255 }
    validates :major_subject, presence: true, length: { maximum: 255 }
end
