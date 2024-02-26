require 'test_helper'

class Classrooms::Resources::CreateNewResourceTest < ActiveSupport::TestCase

    ERROR_MSG_RESOURCE_CREATION_FAILED = Classrooms::Resources::CreateNewResource::RESOURCE_CREATION_FAILED
    ERROR_MSG_ASSIGNMENT_CREATION_FAILED = Classrooms::Resources::CreateNewResource::ASSIGNMENT_CREATION_FAILED

    def setup
        @valid_assignment_params = {
            title: "Assignment title",
            description: "Assignment description",
            resource_type: "assignment",
            url: "http://assignment.com",
            classroom_id: 1,
            due_date: "29 Feb, 2024"
        } 

        @valid_material_params = {
            title: "Material title",
            description: "Material description",
            resource_type: "material",
            url: "http://material.com",
            classroom_id: 1
        } 
        
    end

    test "should create a new material resource with valid parameters" do
        result = Classrooms::Resources::CreateNewResource.call(params: @valid_material_params)

        assert result.success?
        assert_not_nil result.resource
        assert result.resource.persisted?
    end

    test "should create a new assignment resource with valid parameters" do
        result = Classrooms::Resources::CreateNewResource.call(params: @valid_assignment_params)

        assert result.success?
        assert_not_nil result.resource
        assert result.resource.persisted?
        assert result.resource.assignment.persisted?
    end

    test "should fail to create resource with invalid parameters" do
        result = Classrooms::Resources::CreateNewResource.call(params: { title: "only title" })

        assert_not result.success?
        assert_equal ERROR_MSG_RESOURCE_CREATION_FAILED, result.message
        assert_equal result.status, :unprocessable_entity
    end

    test "should fail with an error if resource creation fails" do
        Resource.any_instance.stubs(:save).returns(false)

        result = Classrooms::Resources::CreateNewResource.call(params: @valid_material_params)

        assert_not result.success?
        assert_equal ERROR_MSG_RESOURCE_CREATION_FAILED, result.message
        assert_equal result.status, :unprocessable_entity
    end

    test "should fail to create assignment if incorrect params are passed" do
        invalid_params = @valid_assignment_params.dup
        invalid_params[:due_date] = "" 

        result = Classrooms::Resources::CreateNewResource.call(params: invalid_params)

        assert_not result.success?
        assert_equal ERROR_MSG_ASSIGNMENT_CREATION_FAILED, result.message
        assert_equal result.status, :unprocessable_entity
    end
    
    test "should fail with an error if assignment creation fails" do
        assignment = mock
        assignment.stubs(:persisted?).returns(false)

        Resource.any_instance.stubs(:create_assignment).returns(assignment)

        result = Classrooms::Resources::CreateNewResource.call(params: @valid_assignment_params)

        assert_not result.success?
        assert_nil result.resource
        assert_equal ERROR_MSG_ASSIGNMENT_CREATION_FAILED, result.message
        assert_equal :unprocessable_entity, result.status
    end
end
