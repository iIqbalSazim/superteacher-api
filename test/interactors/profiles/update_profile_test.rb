require 'test_helper'

class Profiles::UpdateProfileTest < ActiveSupport::TestCase

    def setup
        @teacher_user = create(:user, :teacher)
        @student_user = create(:user, :student)
    end

    test 'should update teacher profile with valid parameters' do
        teacher_profile = build_stubbed(:teacher_profile)

        params = {
            highest_education_level: teacher_profile.highest_education_level,
            major_subject: teacher_profile.major_subject,
            subjects_to_teach: teacher_profile.subjects_to_teach
        }

        result = Profiles::UpdateProfile.call(params: params, current_user: @teacher_user)

        assert result.success?
        assert_equal params[:highest_education_level], result.profile.highest_education_level
        assert_equal params[:major_subject], result.profile.major_subject
        assert_equal params[:subjects_to_teach], result.profile.subjects_to_teach
    end

    test 'should update student profile with valid parameters' do
        student_profile = build_stubbed(:student_profile)

        params = {
            education: {
                level: student_profile.education['level'],
                english_bangla_medium: student_profile.education['english_bangla_medium'],
                class_level: student_profile.education['class_level'],
                degree_level: student_profile.education['degree_level'],
                semester_year: student_profile.education['semester_year']
            },
            address: student_profile.address
        }

        result = Profiles::UpdateProfile.call(params: params, current_user: @student_user)

        assert result.success?
        assert_equal params[:education][:level], result.profile.education['level']
        assert_equal params[:education][:degree_level], result.profile.education['degree_level']
        assert_equal params[:education][:semester_year], result.profile.education['semester_year']
        assert_equal params[:address], result.profile.address
    end

    test 'should fail if profile does not exist' do
        user_without_profile = build_stubbed(:user, :math_student)

        params = {
            highest_education_level: 'Masters',
            major_subject: 'Mathematics',
            subjects_to_teach: ['Physics', 'Chemistry']
        }

        result = Profiles::UpdateProfile.call(params: params, current_user: user_without_profile)

        assert_not result.success?
        assert_not_nil result.message
    end
end
