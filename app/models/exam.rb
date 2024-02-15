class Exam < ApplicationRecord
    belongs_to :classroom

    validates :title, presence: true, length: { maximum: 255 }
    validates :description, presence: true, length: { maximum: 1000 }
    validates :classroom_id, presence: true
    validates :date, presence: true
end
