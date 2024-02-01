require 'test_helper'

class GetResourcesTest < ActiveSupport::TestCase
    test "successfully gets resources when correct params are passed" do
        result = Resources::GetResources.call(classroom_id: 1)

        assert result.success?
        assert_not_nil result.resources
    end

    test "fails if incorrect params are passed" do 
        result = Resources::GetResources.call(classroom_id: 0)

        assert_not result.success?
        assert_not_nil result.error
    end

    test "fails if no resources are present in the database" do 
        result = Resources::GetResources.call(classroom_id: 2)

        assert_not result.success?
        assert_not_nil result.error
    end
end