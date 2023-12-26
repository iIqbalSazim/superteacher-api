class TeacherProfile < ApplicationRecord
    belongs_to :user, foreign_key: 'teacher_id'

    validates :highest_education_level, presence: true
    validates :major_subject, presence: true
end
