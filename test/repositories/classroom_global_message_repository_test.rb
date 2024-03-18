require "test_helper"

class ClassroomGlobalMessageRepositoryTest < ActiveSupport::TestCase
    test "success if the ClassroomGlobalMessageRepository extends base_repository" do
        assert_equal BaseRepository, ClassroomGlobalMessageRepository.superclass
    end

    test "#klass matches ClassroomGlobalMessage model" do
        assert_equal ClassroomGlobalMessage, ClassroomGlobalMessageRepository.send(:klass)
    end
end