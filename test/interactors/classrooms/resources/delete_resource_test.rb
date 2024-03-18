require 'test_helper'

class Classrooms::Resources::DeleteResourceTest < ActiveSupport::TestCase

    ERROR_MSG_RESOURCE_DELETE_FAILED = Classrooms::Resources::DeleteResource::RESOURCE_DELETE_FAILED

    def setup
        @classroom = create(:classroom)
    end

    test "delete resource successfully" do
        resource = create(:resource, :material_resource, classroom: @classroom)

        result = Classrooms::Resources::DeleteResource.call(resource_id: resource.id)

        assert result.success?
        assert_nil Resource.find_by(id: resource.id)
    end

    test "fail to delete non-existing resource" do
        resource = create(:resource, :assignment_resource, classroom: @classroom)

        resource_mock = mock
        resource_mock.expects(:destroy).returns(false)

        ResourceRepository.expects(:find_by_id)
                          .with(resource.id)
                          .returns(resource_mock)

        result = Classrooms::Resources::DeleteResource.call(resource_id: resource.id)

        assert_not result.success?
        assert_equal :unprocessable_entity, result.status
        assert_equal ERROR_MSG_RESOURCE_DELETE_FAILED, result.message
    end
end
