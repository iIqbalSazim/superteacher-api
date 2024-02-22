require 'test_helper'

class Api::V1::Classrooms::StudentsControllerTest < ActionController::TestCase
    setup :setup_controller_with_fake_user

    setup do
    end

    test "#index responds with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:students).returns([])

        Classrooms::Students::GetStudentsFlow.expects(:call).returns(interactor_result)

        get :index, params: { filter: "enrolled", classroom_id: "1" }

        assert_response :ok
    end

    

    test "#index does not respond with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:status).returns(:unprocessable_entity)

        Classrooms::Students::GetStudentsFlow.expects(:call).returns(interactor_result)

        get :index, params: { filter: "enrolled", classroom_id: "1" }

        assert_response :unprocessable_entity
    end
end