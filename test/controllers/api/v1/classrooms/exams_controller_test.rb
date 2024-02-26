require 'test_helper'

class Api::V1::Classrooms::ExamsControllerTest < ActionController::TestCase
    setup :setup_controller_with_fake_user

    test "#index responds with success" do
        exam_params = {
            classroom_id: 1
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:exams).returns([])

        Classrooms::Exams::GetExamsFlow.expects(:call).returns(interactor_result)

        get :index, params: exam_params

        assert_response :ok
    end

    test "#index does not respond with success" do
        exam_params = {
            classroom_id: 1
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:message).returns("some error message")

        Classrooms::Exams::GetExamsFlow.expects(:call).returns(interactor_result)

        get :index, params: exam_params

        assert_response :unprocessable_entity
    end

    test "#create responds with success" do
        exam_params = {
            classroom_id: 1,
            exam: {
                title: "Test exam",
                description: "Test description",
                classroom_id: 1,
                date: "30 Mar, 2024"
            }
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:exam).returns({})

        ExamSerializer.any_instance.stubs(:serialize).returns({})

        Classrooms::Exams::CreateNewExamFlow.expects(:call).returns(interactor_result)

        post :create, params: exam_params

        assert_response :ok
    end

    test "#create does not respond with success" do
        exam_params = {
            classroom_id: 1,
            exam: {
                title: "Test exam",
                description: "Test description",
                classroom_id: 1,
                date: "30 Mar, 2024"
            }
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:message).returns("some error")
        interactor_result.expects(:status).returns(:unprocessable_entity)
        
        Classrooms::Exams::CreateNewExamFlow.expects(:call).returns(interactor_result)

        post :create, params: exam_params

        assert_response :unprocessable_entity
    end
end