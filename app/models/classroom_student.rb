class ClassroomStudent < ApplicationRecord
    belongs_to :classroom
    belongs_to :student, class_name: 'User'

    validates :classroom, presence: true
    validates :student, presence: true
end