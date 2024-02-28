class StudentProfile < Profile
    belongs_to :student, class_name: 'User'

    validates :education, presence: true
    validates :address, presence: true, length: { maximum: 1000 }

    validate :validate_education_details

    DEGREE_AND_SEMESTER_MUST_EXIST = "Degree level and Semester year must not be empty for university level education"
    CLASS_AND_MEDIUM_MUST_EXIST = "Class level and English/Bangla medium must not be empty for school or college level education"
    INVALID_EDUCATION_LEVEL = "Invalid education level"
    INVALID_DEGREE_LEVEL = "Degree level must be either 'bachelors' or 'masters'"
    INVALID_SEMESTER_YEAR_LENGTH = "Semester year must not exceed 55 characters"
    INVALID_SCHOOL_CLASS_LEVEL = "Invalid class level for school education"
    INVALID_COLLEGE_CLASS_LEVEL = "Invalid class level for college education"

    SCHOOL_CLASSES = ['Class 7', 'Class 8', 'Class 9', 'Class 10']
    COLLEGE_CLASSES = ['Class 11', 'Class 12']

    def validate_education_details
        if education.present?
            if education["level"] == "School"
                if !SCHOOL_CLASSES.include?(education["class_level"])
                    errors.add(:education, INVALID_SCHOOL_CLASS_LEVEL)
                elsif education["class_level"].blank? || education["english_bangla_medium"].blank?
                    errors.add(:education, CLASS_AND_MEDIUM_MUST_EXIST)
                end
            elsif education["level"] == "College"
                if !COLLEGE_CLASSES.include?(education["class_level"])
                    errors.add(:education, INVALID_COLLEGE_CLASS_LEVEL)
                elsif education["class_level"].blank? || education["english_bangla_medium"].blank?
                    errors.add(:education, CLASS_AND_MEDIUM_MUST_EXIST)
                end
            elsif education["level"] == "University"
                if education["degree_level"].blank? || education["semester_year"].blank?
                    errors.add(:education, DEGREE_AND_SEMESTER_MUST_EXIST)
                elsif !["bachelors", "masters"].include?(education["degree_level"].downcase)
                    errors.add(:education, INVALID_DEGREE_LEVEL)
                elsif education["semester_year"].length > 55
                    errors.add(:education, INVALID_SEMESTER_YEAR_LENGTH)
                end
            else
                errors.add(:education, INVALID_EDUCATION_LEVEL)
            end
        end
    end
end