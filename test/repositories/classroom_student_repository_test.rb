require "test_helper"

class ClassroomStudentRepositoryTest < ActiveSupport::TestCase
    test "success if the ClassroomStudentRepository extends base_repository" do
        assert_equal BaseRepository, ClassroomStudentRepository.superclass
    end

    test "#klass matches ClassroomStudent model" do
        assert_equal ClassroomStudent, ClassroomStudentRepository.send(:klass)
    end

    test "find_by_classroom_and_student_id should return a submission" do
        classroom_student = create(:classroom_student, student_id: 1, classroom_id: 1)

        result = ClassroomStudentRepository.find_by_classroom_and_student_id(1, 1)

        assert_equal classroom_student, result
    end

    test "find_by_classroom_and_student_id should return nil if submission does not exist" do

        result = ClassroomStudentRepository.find_by_classroom_and_student_id(999, 999)

        assert_not result.present?
    end
end