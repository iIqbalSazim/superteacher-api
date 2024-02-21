require 'test_helper'

class Api::V1::ClassroomsControllerTest < ActionController::TestCase
    setup :setup_controller_with_fake_user

    setup do
        @classroom_params = { 
            classroom: {
                teacher_id: 1,
                title: "Test classroom",
                subject: "Biology",
                class_time: "2000-01-01T12:00:00Z",
                meet_link: "meet.google.com",
                days: ["Sunday", "Monday"]
            }
        }
    end

    test "#index responds with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:classrooms).returns([])

        Classrooms::GetClassroomsByUser.expects(:call).with(current_user: @fake_user).returns(interactor_result)

        get :index

        assert_response :ok
    end

    test "#index does not respond with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(false)

        Classrooms::GetClassroomsByUser.expects(:call).with(current_user: @fake_user).returns(interactor_result)

        get :index

        assert_response :unprocessable_entity
    end

    test "#show responds with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:classroom).returns({})

        ClassroomSerializer.any_instance.stubs(:serialize).returns({})

        Shared::FindClassroom.expects(:call).returns(interactor_result)

        get :show, params: { id: 1 }

        assert_response :ok
    end

    test "#show does not respond with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:message).returns("some error")

        Shared::FindClassroom.expects(:call).returns(interactor_result)

        get :show, params: { id: 1 }

        assert_response :unprocessable_entity
    end

    test "#create responds with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(true)
        interactor_result.expects(:new_classroom).returns({})

        ClassroomSerializer.any_instance.stubs(:serialize).returns({})

        Classrooms::CreateClassroom.expects(:call).returns(interactor_result)

        post :create, params: @classroom_params

        assert_response :ok
    end

    test "#create does not respond with success" do
        interactor_result = mock
        interactor_result.expects(:success?).returns(false)
        interactor_result.expects(:message).returns("some error")
        
        Classrooms::CreateClassroom.expects(:call).returns(interactor_result)

        post :create, params: @classroom_params

        assert_response :unprocessable_entity
    end
end