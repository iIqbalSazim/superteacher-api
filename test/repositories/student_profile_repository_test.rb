require "test_helper"

class StudentProfileRepositoryTest < ActiveSupport::TestCase
    test "success if the StudentProfileRepository extends base_repository" do
        assert_equal BaseRepository, StudentProfileRepository.superclass
    end

    test "#klass matches StudentProfile model" do
        assert_equal StudentProfile, StudentProfileRepository.send(:klass)
    end

    test "find_by_student_id should return a profile if profile exists" do
        user_one = create(:user)
        profile = create(:student_profile, student: user_one)

        result = StudentProfileRepository.find_by_student_id(user_one.id)

        assert_equal profile, result
    end

    test "find_by_student_id should return nil if profile does not exist" do

        result = StudentProfileRepository.find_by_student_id(999)

        assert_not result.present?
    end
end