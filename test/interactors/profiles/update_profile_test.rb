require 'test_helper'

class Profiles::UpdateProfileTest < ActiveSupport::TestCase

    ERROR_MSG_PROFILE_DOES_NOT_EXIST = Profiles::UpdateProfile::PROFILE_DOES_NOT_EXIST 
    ERROR_MSG_FAILED_TO_UPDATE = Profiles::UpdateProfile::FAILED_TO_UPDATE 

    def setup
        @teacher_user = create(:user, :teacher)
        @student_user = create(:user, :student)
    end

    test 'should update teacher profile with valid parameters' do
        teacher_profile = create(:teacher_profile, teacher: @teacher_user)
        teacher_profile_params = attributes_for(:teacher_profile, major_subject: "Physics")

        result = Profiles::UpdateProfile.call(params: teacher_profile_params, current_user: @teacher_user)

        assert result.success?
        assert_equal teacher_profile_params[:highest_education_level], result.profile.highest_education_level
        assert_equal teacher_profile_params[:major_subject], result.profile.major_subject
        assert_equal teacher_profile_params[:subjects_to_teach], result.profile.subjects_to_teach
    end

    test 'should update student profile with valid parameters' do
        student_profile = create(:student_profile, student: @student_user)
        student_profile_params = attributes_for(:student_profile)

        result = Profiles::UpdateProfile.call(params: student_profile_params, current_user: @student_user)

        assert result.success?
        assert_equal student_profile_params[:education][:level], result.profile.education['level']
        assert_equal student_profile_params[:education][:degree_level], result.profile.education['degree_level']
        assert_equal student_profile_params[:education][:semester_year], result.profile.education['semester_year']
        assert_equal student_profile_params[:address], result.profile.address
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
        assert_equal ERROR_MSG_PROFILE_DOES_NOT_EXIST, result.message
    end

    test 'should fail if profile fails to update' do
        teacher_profile = create(:teacher_profile, teacher: @teacher_user)
        teacher_profile_params = attributes_for(:teacher_profile, major_subject: "Physics")

        update_teacher_mock = mock
        update_teacher_mock.expects(:valid?).returns(false)

        TeacherProfileRepository.expects(:update)
                               .returns(update_teacher_mock)

        result = Profiles::UpdateProfile.call(params: teacher_profile_params, current_user: @teacher_user)

        assert_not result.success?
        assert_equal ERROR_MSG_FAILED_TO_UPDATE, result.message
    end
end
