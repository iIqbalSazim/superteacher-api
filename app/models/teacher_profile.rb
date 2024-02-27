class TeacherProfile < Profile
    belongs_to :teacher, class_name: 'User'

    VALID_EDUCATION_LEVELS = %w[Bachelors Masters Diploma PhD].freeze

    validates :highest_education_level, presence: true, inclusion: { in: VALID_EDUCATION_LEVELS }
    validates :major_subject, presence: true, length: { maximum: 255 }
    validates :subjects_to_teach, presence: true

    validate :validate_subjects_to_teach_array

    private

    def validate_subjects_to_teach_array
        if subjects_to_teach.present? && !subjects_to_teach.is_a?(Array)
            errors.add(:subjects_to_teach, 'must be an array')
        end
    end
end
