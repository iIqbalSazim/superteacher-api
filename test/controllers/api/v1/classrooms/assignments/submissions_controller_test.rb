require 'test_helper'

class Api::V1::Classrooms::Assignments::SubmissionsControllerTest < ActionController::TestCase
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
        setup_controller_with_fake_student_user

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

        serializer_mock = mock
        serializer_mock.expects(:serialize).returns({})

        SubmissionSerializer.expects(:new).returns(serializer_mock)

        Classrooms::Assignments::Submissions::CreateNewSubmissionFlow.expects(:call).returns(interactor_result)

        post :create, params: submission_params

        assert_response :ok
    end

    test "#create does not respond with success" do
        setup_controller_with_fake_student_user

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

    test "#destroy responds with success" do
        setup_controller_with_fake_student_user

        submission_params = {
            classroom_id: 1,
            assignment_id: 1,
            id: 1
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:submission_id).returns(submission_params[:id])

        Classrooms::Assignments::Submissions::DeleteSubmissionFlow.expects(:call).returns(interactor_result)

        delete :destroy, params: submission_params

        assert_response :ok
    end

    test "#destroy does not respond with success" do
        setup_controller_with_fake_student_user

        submission_params = {
            classroom_id: 1,
            assignment_id: 1,
            id: 1
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:message).returns("some error")
        interactor_result.expects(:status).returns(:unprocessable_entity)
        
        Classrooms::Assignments::Submissions::DeleteSubmissionFlow.expects(:call).returns(interactor_result)

        delete :destroy, params: submission_params

        assert_response :unprocessable_entity
    end
end