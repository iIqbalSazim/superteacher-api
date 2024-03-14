require 'test_helper'

class Classrooms::Resources::UpdateResourceTest < ActiveSupport::TestCase

    ERROR_MSG_RESOURCE_UPDATE_FAILED = Classrooms::Resources::UpdateResource::RESOURCE_UPDATE_FAILED

    def setup
        @classroom = create(:classroom)
        @resource = create(:resource, :material_resource, classroom: @classroom)
    end

    test "update resource with valid parameters" do
        resource_params = attributes_for(:resource, :material_resource, classroom: @classroom)

        result = Classrooms::Resources::UpdateResource.call(
            params: resource_params, 
            resource_id: @resource.id 
        )

        assert result.success?
        assert_equal resource_params[:title], result.resource.title
        assert_equal resource_params[:description], result.resource.description
    end

    test "fail to update resource with invalid parameters" do
        invalid_resource_params = attributes_for(:resource, :material_resource, classroom: @classroom, title: "")
        
        result = Classrooms::Resources::UpdateResource.call(
            params: invalid_resource_params, 
            resource_id: @resource.id
        )

        assert_not result.success?
        assert_equal ERROR_MSG_RESOURCE_UPDATE_FAILED, result.message
        assert_equal :unprocessable_entity, result.status
    end
end
