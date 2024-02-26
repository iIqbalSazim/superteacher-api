require 'test_helper'

class Classrooms::Resources::DeleteResourceTest < ActiveSupport::TestCase

    ERROR_MSG_RESOURCE_DELETE_FAILED = Classrooms::Resources::DeleteResource::RESOURCE_DELETE_FAILED

    test "delete resource successfully" do
        math_resource = resources(:math_resource_one)

        result = Classrooms::Resources::DeleteResource.call(resource_id: math_resource.id)

        assert result.success?
        assert_nil Resource.find_by(id: math_resource.id)
    end

    test "fail to delete non-existing resource" do
        math_resource = resources(:math_resource_one)

        Resource.any_instance.stubs(:destroy).returns(false)

        result = Classrooms::Resources::DeleteResource.call(resource_id: math_resource.id)

        assert_not result.success?
        assert_equal :unprocessable_entity, result.status
        assert_equal ERROR_MSG_RESOURCE_DELETE_FAILED, result.message
        assert Resource.find_by(id: math_resource.id)
    end
end
