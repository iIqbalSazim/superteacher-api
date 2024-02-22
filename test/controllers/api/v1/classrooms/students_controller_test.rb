require 'test_helper'

class Api::V1::Classrooms::StudentsControllerTest < ActionController::TestCase
    setup :setup_controller_with_fake_user

    setup do
        @enroll_student_params = {
            filter: "enrolled",
            classroom_id: 1,
            classroom_student: {
                student_id: 11,
                classroom_id: 1
            }
        }
    end

    test "#index responds with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:students).returns([])

        Classrooms::Students::GetStudentsFlow.expects(:call).returns(interactor_result)

        get :index, params: @enroll_student_params

        assert_response :ok
    end

    test "#index does not respond with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:status).returns(:unprocessable_entity)

        Classrooms::Students::GetStudentsFlow.expects(:call).returns(interactor_result)

        get :index, params: @enroll_student_params

        assert_response :unprocessable_entity
    end

    test "#enroll responds with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:student).returns({})

        UserSerializer.any_instance.stubs(:serialize).returns({})

        Classrooms::Students::EnrollStudentFlow.expects(:call).returns(interactor_result)

        post :enroll, params: @enroll_student_params

        assert_response :ok
    end

    test "#enroll does not respond with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:message).returns("some error message")
        interactor_result.expects(:status).returns(:unprocessable_entity)

        Classrooms::Students::EnrollStudentFlow.expects(:call).returns(interactor_result)

        post :enroll, params: @enroll_student_params

        assert_response :unprocessable_entity
    end
end