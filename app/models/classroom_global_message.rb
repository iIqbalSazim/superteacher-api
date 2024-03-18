class ClassroomGlobalMessage < ApplicationRecord
    belongs_to :classroom
    belongs_to :user

    validates :text, presence: true, length: { minimum: 1, maximum: 10000 }
    validates :user_id, presence: true
    validates :classroom_id, presence: true
end