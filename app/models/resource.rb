class Resource < ApplicationRecord
    belongs_to :classroom
    enum resource_type: { assignment: 'assignment', material: 'material' }

    validates :title, presence: true, length: { maximum: 255 }
    validates :description, presence: true, length: { maximum: 1000 }
    validates :resource_type, presence: true
    validates :url, presence: true, length: { maximum: 1000 }
    validates :classroom_id, presence: true
end
