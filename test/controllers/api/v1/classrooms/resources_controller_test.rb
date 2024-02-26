require 'test_helper'

class Api::V1::Classrooms::ResourcesControllerTest < ActionController::TestCase
    setup :setup_controller_with_fake_user

    test "#index responds with success" do
        resource_params = {
            classroom_id: 1
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:resources).returns([])

        Classrooms::Resources::GetResourcesFlow.expects(:call).returns(interactor_result)

        get :index, params: resource_params

        assert_response :ok
    end

    test "#index does not respond with success" do
        resource_params = {
            classroom_id: 1
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:message).returns("some error message")

        Classrooms::Resources::GetResourcesFlow.expects(:call).returns(interactor_result)

        get :index, params: resource_params

        assert_response :unprocessable_entity
    end

    test "#create responds with success" do
        resource_params = {
            classroom_id: 1,
            resource: {
                title: "Test resource",
                description: "Test description",
                classroom_id: 1
            }
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:resource).returns({})

        ResourceSerializer.any_instance.stubs(:serialize).returns({})

        Classrooms::Resources::CreateNewResourceFlow.expects(:call).returns(interactor_result)

        post :create, params: resource_params

        assert_response :ok
    end

    test "#create does not respond with success" do
        resource_params = {
            classroom_id: 1,
            resource: {
                title: "Test resource",
                description: "Test description",
                classroom_id: 1
            }
        }

        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:message).returns("some error")
        interactor_result.expects(:status).returns(:unprocessable_entity)
        
        Classrooms::Resources::CreateNewResourceFlow.expects(:call).returns(interactor_result)

        post :create, params: resource_params

        assert_response :unprocessable_entity
    end
end