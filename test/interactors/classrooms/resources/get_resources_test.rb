require 'test_helper'

class Classrooms::Resources::GetResourcesTest < ActiveSupport::TestCase

    test "should get resources by classroom_id" do
        classroom_id = classrooms(:math_classroom).id

        existing_resources = [resources(:math_resource_one)]

        result = Classrooms::Resources::GetResources.call(classroom_id: classroom_id)

        assert result.success?
        assert_equal existing_resources, result.resources
    end

    test "should return empty array if no resources" do
        classroom_id = classrooms(:empty_classroom).id

        result = Classrooms::Resources::GetResources.call(classroom_id: classroom_id)

        assert result.success?
        assert_equal [], result.resources
    end
end
