require 'test_helper'

class Classrooms::Resources::GetResourcesTest < ActiveSupport::TestCase

    test "should get resources by classroom_id" do
        classroom = create(:classroom)

        resource_1 = create(:resource, :assignment_resource, classroom: classroom)
        resource_2 = create(:resource, :assignment_resource, classroom: classroom)

        existing_resources = [resource_1, resource_2]

        result = Classrooms::Resources::GetResources.call(classroom_id: classroom.id)

        assert result.success?
        assert_equal existing_resources, result.resources
    end

    test "should return empty array if no resources" do
        classroom = create(:classroom)

        result = Classrooms::Resources::GetResources.call(classroom_id: classroom.id)

        assert result.success?
        assert_equal [], result.resources
    end
end
