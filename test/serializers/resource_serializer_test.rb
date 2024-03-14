require 'test_helper'

class ResourceSerializerTest < ActiveSupport::TestCase

    def setup
        @classroom = create(:classroom)
        @resource = build_stubbed(:resource, :assignment_resource, classroom: @classroom)
    end

    test 'should render correct attributes' do
        serialized_object = ResourceSerializer.new.serialize(@resource)
        parsed_object = JSON.parse(serialized_object.to_json)

        assert_equal @resource[:id], parsed_object['id']
        assert_equal @resource[:title], parsed_object['title']
        assert_equal @resource[:description], parsed_object['description']
        assert_equal @resource[:resource_type], parsed_object['resource_type']
        assert_equal @resource[:classroom_id], parsed_object['classroom_id']
        assert_equal @resource[:url], parsed_object['url']
    end

    test "should serialize due_date, assignment_id and submissions if resource_type is assignment" do
        serialized_object = ResourceSerializer.new.serialize(@resource)

        assert_equal @resource.assignment.due_date, serialized_object["due_date"]
        assert_equal @resource.assignment.id, serialized_object["assignment_id"]
        assert_equal @resource.assignment.submissions.length, serialized_object["submissions"].length
    end

    test "should not serialize due_date, assignment_id and submissions if resource_type is material" do
        @resource[:resource_type] = "material"

        serialized_object = ResourceSerializer.new.serialize(@resource)

        assert_nil serialized_object["due_date"]
        assert_nil serialized_object["assignment_id"]
        assert_nil serialized_object["submissions"]
    end
end