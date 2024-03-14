require 'test_helper'

class Api::V1::ProfilesControllerTest < ActionController::TestCase
    setup :setup_controller_with_fake_user

    test "should update teacher profile with valid parameters" do
        teacher = create(:user, :teacher)

        teacher_profile_params = {
            id: teacher.id,
            profile: {
                first_name: "John",
                last_name: "Doe",
                gender: "Male",
                highest_education_level: "Bachelors",
                major_subject: "Mathematics",
                subjects_to_teach: ["Math", "Physics"],
            }
        }


        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:user).returns(teacher)

        Profiles::UpdateProfileFlow.expects(:call).returns(interactor_result)

        put :update, params: teacher_profile_params

        assert_response :ok
        assert_equal teacher.id, JSON.parse(response.body)["user"]["id"]
    end

    test "should update student profile with valid parameters" do
        student = create(:user, :student)

        student_profile_params = {
            id: student.id,
            profile: {
                first_name: "Alice",
                last_name: "Smith",
                gender: "Female",
                phone_number: "12345678901",
                address: "456 Elm St",
                education: {
                    level: "High School",
                    english_bangla_medium: "English",
                    class_level: "Senior",
                    degree_level: "Undergraduate",
                    semester_year: "2023"
                }
            }
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:user).returns(student)

        Profiles::UpdateProfileFlow.expects(:call).returns(interactor_result)

        put :update, params: student_profile_params

        assert_response :ok
        assert_equal student.id, JSON.parse(response.body)["user"]["id"]
    end

    test "should not update profile with invalid parameters" do
        invalid_params = { id: 999, profile: { first_name: "" } }

        put :update, params: invalid_params

        assert_response :unprocessable_entity
        assert_not_nil JSON.parse(response.body)["message"]
    end
end
