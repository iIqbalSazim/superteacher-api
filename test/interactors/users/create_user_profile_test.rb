require 'test_helper'

class Users::CreateUserProfileTest < ActiveSupport::TestCase
    def setup
        @teacher_params = {
            user_data: users(:teacher_user_2),
            user_params: {
                role: "teacher",
                highest_education_level: "PhD",
                major_subject: "Mathematics",
                subjects_to_teach: "Algebra, Geometry"
            }
        }

        @student_params = {
            user_data: users(:student_user_2),
            user_params: {
                role: "student",
                education: {
                level: "University",
                english_bangla_medium: "",
                class_level: "",
                degree_level: "Bachelors",
                semester_year: "2023"
                },
                address: "Test address"
            }
        }
    end

    test "creates teacher profile when correct params are passed" do
        result = Users::CreateUserProfile.call(@teacher_params)

        assert result.success?
        assert_instance_of TeacherProfile, result.profile_data
    end

    test "creates student profile when correct params are passed" do
        result = Users::CreateUserProfile.call(@student_params)

        assert result.success?
        assert_instance_of StudentProfile, result.profile_data
    end

    test "fails to create teacher profile when profile data is invalid" do
        invalid_teacher_params = @teacher_params.dup
        invalid_teacher_params[:user_params][:highest_education_level] = nil

        result = Users::CreateUserProfile.call(invalid_teacher_params)

        assert_not result.success?
        assert_nil result.profile_data
        assert_equal "Failed to create teacher profile", result.message
    end

    test "fails to create student profile when profile data is invalid" do
        invalid_user_params = @student_params.dup
        invalid_user_params[:user_params][:address] = nil

        result = Users::CreateUserProfile.call(invalid_user_params)

        assert_not result.success?
        assert_nil result.profile_data
        assert_equal "Failed to create student profile", result.message
    end
end
