require "test_helper"

class AssignmentRepositoryTest < ActiveSupport::TestCase
    test "success if the AssignmentRepository extends base_repository" do
        assert_equal BaseRepository, AssignmentRepository.superclass
    end

    test "#klass matches Assignment model" do
        assert_equal Assignment, AssignmentRepository.send(:klass)
    end
end