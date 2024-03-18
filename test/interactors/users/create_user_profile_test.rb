require 'test_helper'

class Users::CreateUserProfileTest < ActiveSupport::TestCase

    ERROR_MSG_PROFILE_CREATION_FAILED = Users::CreateUserProfile::PROFILE_CREATION_FAILED
    ERROR_MSG_STUDENT_PROFILE_CREATION_FAILED = Users::CreateUserProfile::STUDENT_PROFILE_CREATION_FAILED
    ERROR_MSG_TEACHER_PROFILE_CREATION_FAILED = Users::CreateUserProfile::TEACHER_PROFILE_CREATION_FAILED

    test "creates teacher profile when correct params are passed" do
        teacher = create(:user, :math_teacher)

        teacher_params = {
            user_data: teacher,
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
        student = create(:user, :unenrolled_student)

        student_params = {
            user_data: student,
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
        teacher = create(:user, :math_teacher)

        invalid_teacher_params = {
            user_data: teacher,
            user_params: {
                    role: "teacher",
                    highest_education_level: "",
                    major_subject: "Mathematics",
                    subjects_to_teach: "Algebra, Geometry"
                }
        }

        teacher_profile_mock = mock
        teacher_profile_mock.expects(:save).returns(false)

        teacher.expects(:destroy)

        TeacherProfileRepository.expects(:new)
                               .returns(teacher_profile_mock)

        result = Users::CreateUserProfile.call(invalid_teacher_params)

        assert_not result.success?
        assert_nil result.profile_data
        assert_equal :unprocessable_entity, result.status
        assert_equal ERROR_MSG_TEACHER_PROFILE_CREATION_FAILED, result.message
    end

    test "fails to create student profile when profile data is invalid" do
        student = create(:user, :unenrolled_student)

        invalid_student_params = {
            user_data: student,
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

        student_profile_mock = mock
        student_profile_mock.expects(:save).returns(false)

        StudentProfileRepository.expects(:new)
                               .returns(student_profile_mock)

        student.expects(:destroy)

        result = Users::CreateUserProfile.call(invalid_student_params)

        assert_not result.success?
        assert_nil result.profile_data
        assert_equal :unprocessable_entity, result.status
        assert_equal ERROR_MSG_STUDENT_PROFILE_CREATION_FAILED, result.message
    end
end
