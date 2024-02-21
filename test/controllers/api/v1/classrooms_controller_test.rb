require 'test_helper'

class Api::V1::ClassroomsControllerTest < ActionController::TestCase
    setup :setup_controller_with_fake_user

    test "#index responds with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:classrooms).returns([])

        Classrooms::GetClassroomsByUser.expects(:call).with(current_user: @fake_user).returns(interactor_result)

        get :index

        assert_response :ok
    end

    test "#index does not respond with success when wrong params are passed" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(false)

        Classrooms::GetClassroomsByUser.expects(:call).with(current_user: @fake_user).returns(interactor_result)

        get :index

        assert_response :unprocessable_entity
    end
end