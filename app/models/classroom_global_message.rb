class ClassroomGlobalMessage < ApplicationRecord
    belongs_to :classroom
    has_one :user

    validates :text, presence: true, length: { maximum: 1000 }
    validates :user_id, presence: true
    validates :classroom_id, presence: true
end