class ClassroomGlobalMessage < ApplicationRecord
    belongs_to :user
    belongs_to :classroom

    validates :text, presence: true
    validates :user_id, presence: true
    validates :classroom_id, presence: true
end