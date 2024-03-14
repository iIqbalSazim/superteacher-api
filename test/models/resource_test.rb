require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
    should belong_to(:classroom)
    should have_one(:assignment)

    should validate_presence_of(:title)
    should validate_presence_of(:description)
    should validate_presence_of(:resource_type)
    should validate_presence_of(:url)
    should validate_presence_of(:classroom_id)

    def setup
        @classroom = create(:classroom)
    end

    test "resource is created with validations passing" do
        classroom = create(:classroom)

        valid_resource = build(:resource, :assignment_resource, classroom: classroom)

        assert valid_resource.valid?
        assert_empty valid_resource.errors
    end

    test "resource fails to create with validations failing" do
        invalid_resource = build(:resource, :assignment_resource, resource_type: "", description: "", title: "", url: "", classroom_id: "")

        assert_not invalid_resource.valid?
        assert_not_empty invalid_resource.errors[:title]
        assert_not_empty invalid_resource.errors[:description]
        assert_not_empty invalid_resource.errors[:resource_type]
        assert_not_empty invalid_resource.errors[:url]
        assert_not_empty invalid_resource.errors[:classroom_id]
    end

    test "method resource.assignment? should return true if resource_type is assignment" do
        classroom = create(:classroom)

        assignment_resource = build(:resource, :assignment_resource, classroom: classroom)

        assert assignment_resource.assignment?
        assert_not assignment_resource.material?
    end

    test "method resource.material? should return true if resource_type is material" do
        classroom = create(:classroom)

        material_resource = build(:resource, :material_resource, classroom: classroom)

        assert material_resource.material?
        assert_not material_resource.assignment?
    end
end
