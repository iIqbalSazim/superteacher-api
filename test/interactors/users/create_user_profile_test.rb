require 'test_helper'

class Users::CreateUserProfileTest < ActiveSupport::TestCase

    ERROR_MSG_PROFILE_CREATION_FAILED = Users::CreateUserProfile::PROFILE_CREATION_FAILED
    ERROR_MSG_STUDENT_PROFILE_CREATION_FAILED = Users::CreateUserProfile::STUDENT_PROFILE_CREATION_FAILED
    ERROR_MSG_TEACHER_PROFILE_CREATION_FAILED = Users::CreateUserProfile::TEACHER_PROFILE_CREATION_FAILED

    test "creates teacher profile when correct params are passed" do
        teacher_params = {
            user_data: users(:math_teacher),
            user_params: {
                role: "teacher",
                highest_education_level: "PhD",
                major_subject: "Mathematics",
                subjects_to_teach: "Algebra, Geometry"
            }
        }

        result = Users::CreateUserProfile.call(teacher_params)

        assert result.success?
        assert_instance_of TeacherProfile, result.profile_data
    end

    test "creates student profile when correct params are passed" do
        student_params = {
            user_data: users(:unenrolled_student),
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

        result = Users::CreateUserProfile.call(student_params)

        assert result.success?
        assert_instance_of StudentProfile, result.profile_data
    end

    test "fails to create teacher profile when profile data is invalid" do
        invalid_teacher_params = {
            user_data: users(:math_teacher),
            user_params: {
                role: "teacher",
                highest_education_level: "",
                major_subject: "Mathematics",
                subjects_to_teach: "Algebra, Geometry"
            }
        }

        result = Users::CreateUserProfile.call(invalid_teacher_params)

        assert_not result.success?
        assert_nil result.profile_data
        assert_equal :unprocessable_entity, result.status
        assert_equal ERROR_MSG_TEACHER_PROFILE_CREATION_FAILED, result.message
    end

    test "fails to create student profile when profile data is invalid" do
        invalid_student_params = {
            user_data: users(:unenrolled_student),
            user_params: {
                role: "student",
                education: {
                    level: "University",
                    english_bangla_medium: "",
                    class_level: "",
                    degree_level: "Bachelors",
                    semester_year: "2023"
                },
                address: ""
            }
        }

        result = Users::CreateUserProfile.call(invalid_student_params)

        assert_not result.success?
        assert_nil result.profile_data
        assert_equal :unprocessable_entity, result.status
        assert_equal ERROR_MSG_STUDENT_PROFILE_CREATION_FAILED, result.message
    end
end