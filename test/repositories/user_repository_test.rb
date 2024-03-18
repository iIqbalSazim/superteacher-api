require "test_helper"

class UserRepositoryTest < ActiveSupport::TestCase
    test "success if the UserRepository extends base_repository" do
        assert_equal BaseRepository, UserRepository.superclass
    end

    test "#klass matches User model" do
        assert_equal User, UserRepository.send(:klass)
    end

    test "find_user_by_email should return a user if user exists" do
        user_one = create(:user)

        result = UserRepository.find_user_by_email(user_one[:email])

        assert_equal user_one, result
    end

    test "find_user_by_email should return nil if user does not exist" do

        result = UserRepository.find_user_by_email("non@existent.com")

        assert_not result.present?
    end

    test "fetch_enrolled_students should return enrolled students" do
        enrolled_students = create_list(:user, 3, role: "student")
        unenrolled_students = create_list(:user, 2, role: "student")

        enrolled_student_ids = enrolled_students.map(&:id)

        result = UserRepository.fetch_enrolled_students(enrolled_student_ids)

        assert_equal enrolled_students, result
        assert_not_includes result, unenrolled_students
    end

    test "fetch_unenrolled_students should return unenrolled students" do
        enrolled_students = create_list(:user, 3, role: "student")

        enrolled_student_ids = enrolled_students.map(&:id)

        result = UserRepository.fetch_unenrolled_students(enrolled_student_ids)

        assert_not_includes result, enrolled_students
    end
end