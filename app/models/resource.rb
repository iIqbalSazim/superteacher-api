class Resource < ApplicationRecord
    belongs_to :classroom
    enum resource_type: { assignment: 'assignment', material: 'material' }

    has_one :assignment

    validates :title, presence: true, length: { maximum: 255 }
    validates :description, presence: true, length: { maximum: 1000 }
    validates :resource_type, presence: true
    validates :url, presence: true, length: { maximum: 1000 }
    validates :classroom_id, presence: true

    def assignment?
        self[:resource_type] == "assignment"
    end

    def material?
        self[:resource_type] == "material"
    end
end
