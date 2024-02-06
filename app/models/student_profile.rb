class StudentProfile < Profile
    belongs_to :student, class_name: 'User'

    validates :education, presence: true, length: { maximum: 255 }
    validates :address, presence: true, length: { maximum: 1000 }
end
