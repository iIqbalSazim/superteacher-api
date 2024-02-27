require 'test_helper'

class Profiles::UpdateProfileTest < ActiveSupport::TestCase

    ERROR_MSG_PROFILE_DOES_NOT_EXIST = 'Profile does not exist in the database'

    def setup
        @teacher_user = users(:math_teacher)
        @student_user = users(:math_student)
    end

    test 'should update teacher profile with valid parameters' do
        teacher_profile = teacher_profiles(:math_teacher_profile)

        params = {
            highest_education_level: 'Masters',
            major_subject: 'Mathematics',
            subjects_to_teach: ['Physics', 'Chemistry']
        }

        result = Profiles::UpdateProfile.call(params: params, current_user: @teacher_user)

        assert result.success?
        assert_equal params[:highest_education_level], result.profile.highest_education_level
        assert_equal params[:major_subject], result.profile.major_subject
        assert_equal params[:subjects_to_teach], result.profile.subjects_to_teach
    end

    test 'should update student profile with valid parameters' do
        student_profile = student_profiles(:math_student_profile)

        params = {
            education: {
                level: 'University',
                english_bangla_medium: '',
                class_level: '',
                degree_level: 'Bachelors',
                semester_year: '2023'
            },
            address: '123 Main St'
        }

        result = Profiles::UpdateProfile.call(params: params, current_user: @student_user)

        assert result.success?
        assert_equal params[:education][:level], result.profile.education['level']
        assert_equal params[:education][:degree_level], result.profile.education['degree_level']
        assert_equal params[:education][:semester_year], result.profile.education['semester_year']
        assert_equal params[:address], result.profile.address
    end

    test 'should fail if profile does not exist' do
        user_without_profile = users(:biology_classroom_teacher)

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
