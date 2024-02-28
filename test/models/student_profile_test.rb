require 'test_helper'

class StudentProfileTest < ActiveSupport::TestCase
    def setup
        @student_profile = student_profiles(:math_student_profile)
    end

    should validate_presence_of(:education)
    should validate_presence_of(:address)

    test 'student profile is created with validations passing when education level is university' do
        valid_student_profile = StudentProfile.new(
            student_id: 12,
            education: {
                level: "University",
                english_bangla_medium: "",
                class_level: "",
                degree_level: "Bachelors",
                semester_year: "2023"
            },
            address: "Test address"
        )

        assert valid_student_profile.valid?
        assert_empty valid_student_profile.errors
    end

    test 'student profile fails to create with validations failing when education level is university' do
        invalid_student_profile = StudentProfile.new(
            student_id: 12,
            education: {
                level: "University",
                english_bangla_medium: "",
                class_level: "",
                degree_level: "",
                semester_year: ""
            },
            address: "Test address"
        )

        assert_not invalid_student_profile.valid?
        assert_not_empty invalid_student_profile.errors[:education]
        assert_equal StudentProfile::DEGREE_AND_SEMESTER_MUST_EXIST, invalid_student_profile.errors[:education][0]
    end

    test "student profile is created with validations passing when education level is school" do
        valid_student_profile = StudentProfile.new(
            student_id: 12,
            education: {
                level: "School",
                english_bangla_medium: "English",
                class_level: "Class 7",
                degree_level: "",
                semester_year: ""
            },
            address: "Test address"
        )

        assert valid_student_profile.valid?
        assert_empty valid_student_profile.errors
    end

    test "student profile is created with validations passing when education level is college" do
        valid_student_profile = StudentProfile.new(
            student_id: 12,
            education: {
                level: "College",
                english_bangla_medium: "English",
                class_level: "Class 11",
                degree_level: "",
                semester_year: ""
            },
            address: "Test address"
        )

        assert valid_student_profile.valid?
        assert_empty valid_student_profile.errors
    end

    test "student profile fails to create with validations failing when class level is invalid for school" do
        invalid_student_profile = StudentProfile.new(
            student_id: 12,
            education: {
                level: "School",
                english_bangla_medium: "English",
                class_level: "Class 6",
                degree_level: "",
                semester_year: ""
            },
            address: "Test address"
        )

        assert_not invalid_student_profile.valid?
        assert_not_empty invalid_student_profile.errors[:education]
        assert_equal StudentProfile::INVALID_SCHOOL_CLASS_LEVEL, invalid_student_profile.errors[:education][0]
    end

    test "student profile fails to create with validations failing when class level is invalid for college" do
        invalid_student_profile = StudentProfile.new(
            student_id: 12,
            education: {
                level: "College",
                english_bangla_medium: "English",
                class_level: "Class 10",
                degree_level: "",
                semester_year: ""
            },
            address: "Test address"
        )

        assert_not invalid_student_profile.valid?
        assert_not_empty invalid_student_profile.errors[:education]
        assert_equal StudentProfile::INVALID_COLLEGE_CLASS_LEVEL, invalid_student_profile.errors[:education][0]
    end

    test 'profile fails to be created with validations failing' do
        valid_student_profile = StudentProfile.new(
            student_id: 12,
            education: {
                level: "",
                english_bangla_medium: "",
                class_level: "",
                degree_level: "",
                semester_year: ""
            },
            address: "Test address"
        )

        assert_not valid_student_profile.valid?
        assert valid_student_profile.errors
    end

    test "education should not be too long" do
        @student_profile.education = "a" * 256

        assert_not @student_profile.valid?
    end

    test "address should not be too long" do
        @student_profile.address = "a" * 1001

        assert_not @student_profile.valid?
    end
end
