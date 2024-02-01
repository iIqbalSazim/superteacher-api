require 'test_helper'

class CreateNewResourceTest < ActiveSupport::TestCase
    test "successfuly created new resource when correct params are passed" do
        resource_params = { title: "New test resource", description: "test", resource_type: "assignment", url: "http://mock_link.com", classroom_id: 1}

        result = Resources::CreateNewResource.call(resource_params: resource_params)

        assert result.success?
        assert_not_nil result.resource
    end

    test "fails if incorrect params are passed" do 
        result = Resources::CreateNewResource.call({ title: "New test", description: "test", resource_type: "assignment", url: "http://mock_link.com", classroom_id: 0})

        assert_not result.success?
        assert_not_nil result.error
    end
end