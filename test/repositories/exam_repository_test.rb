require "test_helper"

class ExamRepositoryTest < ActiveSupport::TestCase
    test "success if the ExamRepository extends base_repository" do
        assert_equal BaseRepository, ExamRepository.superclass
    end

    test "#klass matches Exam model" do
        assert_equal Exam, ExamRepository.send(:klass)
    end
end