require 'test_helper'

class TeacherProfileTest < ActiveSupport::TestCase
    def setup
        @teacher_profile = teacher_profiles(:math_teacher_profile)
    end

    should validate_presence_of(:highest_education_level)
    should validate_presence_of(:major_subject)
    should validate_presence_of(:subjects_to_teach)

    test 'teacher profile is created with validations passing' do
        valid_teacher_profile = TeacherProfile.new(
            teacher_id: 12,
            highest_education_level: 'Masters',
            major_subject: 'English',
            subjects_to_teach: ['Biology', 'Physics']
        )

        assert valid_teacher_profile.valid?
        assert_empty valid_teacher_profile.errors
    end

    test 'teacher profile fails to create with validations failing when highest education level is invalid' do
        invalid_teacher_profile = TeacherProfile.new(
            teacher_id: 12,
            highest_education_level: 'Undergraduate',
            major_subject: 'Physics',
            subjects_to_teach: ['Biology', 'Physics']
        )

        assert_not invalid_teacher_profile.valid?
        assert_not_empty invalid_teacher_profile.errors[:highest_education_level]
        assert_equal ['is not included in the list'], invalid_teacher_profile.errors[:highest_education_level]
    end

    test 'teacher profile fails to create with validations failing when subjects to teach is not an array' do
        invalid_teacher_profile = TeacherProfile.new(
            teacher_id: 12,
            highest_education_level: 'Masters',
            major_subject: 'Physics',
            subjects_to_teach: 'Biology'
        )

        assert_not invalid_teacher_profile.valid?
        assert_not_empty invalid_teacher_profile.errors[:subjects_to_teach]
    end

    test 'profile fails to be created with validations failing' do
        valid_teacher_profile = TeacherProfile.new(
            teacher_id: 12,
            highest_education_level: '',
            major_subject: '',
            subjects_to_teach: []
        )

        assert_not valid_teacher_profile.valid?
        assert valid_teacher_profile.errors
    end

    test 'highest education level should not be too long' do
        @teacher_profile.highest_education_level = 'a' * 256

        assert_not @teacher_profile.valid?
    end

    test 'major subject should not be too long' do
        @teacher_profile.major_subject = 'a' * 256

        assert_not @teacher_profile.valid?
    end
end
