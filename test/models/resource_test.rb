require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
    should belong_to(:classroom)
    should have_one(:assignment)

    should validate_presence_of(:title)
    should validate_presence_of(:description)
    should validate_presence_of(:resource_type)
    should validate_presence_of(:url)
    should validate_presence_of(:classroom_id)

    test "resource is created with validations passing" do
        valid_resource = Resource.new(
            title: "New resource",
            description: "New resource description",
            classroom_id: 1, 
            resource_type: "assignment",
            url: "http://example-url.com"
        )

        assert valid_resource.valid?
        assert_empty valid_resource.errors
    end

    test "resource fails to create with validations failing" do
        invalid_resource = Resource.new

        assert_not invalid_resource.valid?
        assert_not_empty invalid_resource.errors[:title]
        assert_not_empty invalid_resource.errors[:description]
        assert_not_empty invalid_resource.errors[:resource_type]
        assert_not_empty invalid_resource.errors[:url]
        assert_not_empty invalid_resource.errors[:classroom_id]
    end

    test "method resource.assignment? should return true if resource_type is assignment" do
        assignment_resource = resources(:math_resource_one)

        assert assignment_resource.assignment?
        assert_not assignment_resource.material?
    end

    test "method resource.material? should return true if resource_type is material" do
        material_resource = resources(:biology_resource_one)

        assert material_resource.material?
        assert_not material_resource.assignment?
    end
end
