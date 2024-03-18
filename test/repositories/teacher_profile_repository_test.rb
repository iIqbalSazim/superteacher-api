require "test_helper"

class TeacherProfileRepositoryTest < ActiveSupport::TestCase
    test "success if the TeacherProfileRepository extends base_repository" do
        assert_equal BaseRepository, TeacherProfileRepository.superclass
    end

    test "#klass matches TeacherProfile model" do
        assert_equal TeacherProfile, TeacherProfileRepository.send(:klass)
    end

    test "find_by_teacher_id should return a profile if profile exists" do
        user_one = create(:user)
        profile = create(:teacher_profile, teacher: user_one)

        result = TeacherProfileRepository.find_by_teacher_id(user_one.id)

        assert_equal profile, result
    end

    test "find_by_teacher_id should return nil if profile does not exist" do

        result = TeacherProfileRepository.find_by_teacher_id(999)

        assert_not result.present?
    end
end