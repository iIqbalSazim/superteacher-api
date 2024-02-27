require 'test_helper'

class Api::V1::Classrooms::Assignments::SubmissionsControllerTest < ActionController::TestCase
    setup :setup_controller_with_fake_student_user

    test "#index responds with success" do
        setup_controller_with_fake_user

        submission_params = {
            classroom_id: 1,
            assignment_id: 1
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:submissions).returns([])

        Classrooms::Assignments::Submissions::GetSubmissionsFlow.expects(:call).returns(interactor_result)

        get :index, params: submission_params

        assert_response :ok
    end

    test "#index does not respond with success" do
        setup_controller_with_fake_user

        submission_params = {
            classroom_id: 1,
            assignment_id: 1
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:message).returns("some error message")

        Classrooms::Assignments::Submissions::GetSubmissionsFlow.expects(:call).returns(interactor_result)

        get :index, params: submission_params

        assert_response :unprocessable_entity
    end

    test "#create responds with success" do
        submission_params = {
            classroom_id: 1,
            assignment_id: 1,
            submission: {
                student_id: 1,
                assignment_id: 1,
                submitted_on: "30 Mar, 2024",
                url: "http://exampleSubmission.com"
            }
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:submission).returns({})

        SubmissionSerializer.any_instance.stubs(:serialize).returns({})

        Classrooms::Assignments::Submissions::CreateNewSubmissionFlow.expects(:call).returns(interactor_result)

        post :create, params: submission_params

        assert_response :ok
    end

    test "#create does not respond with success" do
        submission_params = {
            classroom_id: 1,
            assignment_id: 1,
            submission: {
                student_id: 1,
                assignment_id: 1,
                submitted_on: "30 Mar, 2024",
                url: "http://exampleSubmission.com"
            }
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:message).returns("some error")
        
        Classrooms::Assignments::Submissions::CreateNewSubmissionFlow.expects(:call).returns(interactor_result)

        post :create, params: submission_params

        assert_response :unprocessable_entity
    end
end