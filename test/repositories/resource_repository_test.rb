require "test_helper"

class ResourceRepositoryTest < ActiveSupport::TestCase
    test "success if the ResourceRepository extends base_repository" do
        assert_equal BaseRepository, ResourceRepository.superclass
    end

    test "#klass matches Resource model" do
        assert_equal Resource, ResourceRepository.send(:klass)
    end
end