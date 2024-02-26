require 'test_helper'

class Classrooms::Resources::UpdateResourceTest < ActiveSupport::TestCase

    ERROR_MSG_RESOURCE_UPDATE_FAILED = Classrooms::Resources::UpdateResource::RESOURCE_UPDATE_FAILED

    test "update resource with valid parameters" do
        resource_params = {
            title: "Resource title",
            description: "Resource description",
            url: "http://example.com",
            due_date: "30 May, 2024"
        }

        result = Classrooms::Resources::UpdateResource.call(
            params: resource_params, 
            resource_id: 1 
        )

        assert result.success?
        assert_equal resource_params[:title], result.resource.title
        assert_equal resource_params[:description], result.resource.description
        assert_equal DateTime.parse(resource_params[:due_date]), result.resource.assignment.due_date
    end

    test "fail to update resource with invalid parameters" do
        invalid_resource_params = {
            title: ""
        }

        result = Classrooms::Resources::UpdateResource.call(
            params: invalid_resource_params, 
            resource_id: 1 
        )

        assert_not result.success?
        assert_equal ERROR_MSG_RESOURCE_UPDATE_FAILED, result.message
        assert_equal :unprocessable_entity, result.status
    end
end
