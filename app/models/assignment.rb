class Assignment < ApplicationRecord
    belongs_to :resource
    has_many :submissions

    validates :due_date, presence: true
end