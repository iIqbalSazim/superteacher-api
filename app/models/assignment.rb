class Assignment < ApplicationRecord
    belongs_to :resource

    validates :due_date, presence: true
end