class TeacherProfile < Profile
    belongs_to :teacher, class_name: 'User'

    validates :highest_education_level, presence: true, length: { maximum: 255 }
    validates :major_subject, presence: true, length: { maximum: 255 }
end
