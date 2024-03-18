require "test_helper"

class ClassroomRepositoryTest < ActiveSupport::TestCase
    test "success if the ClassroomRepository extends base_repository" do
        assert_equal BaseRepository, ClassroomRepository.superclass
    end

    test "#klass matches Classroom model" do
        assert_equal Classroom, ClassroomRepository.send(:klass)
    end

    test "#find_by_teacher_id returns classroom for a teacher" do
        teacher = create(:user, :teacher)
        classrooms = create_list(:classroom, 3, teacher: teacher)

        classrooms_from_repo = ClassroomRepository.find_by_teacher_id(teacher.id)

        assert_not_nil classrooms_from_repo
        assert_equal classrooms.count, classrooms_from_repo.count
        classrooms_from_repo.each do |classroom|
            assert_equal teacher.id, classroom.teacher_id
        end
    end

    test "#find_by_student_id returns classrooms for a student" do
        student = create(:user, :student)
        classrooms = create_list(:classroom, 3)
        classrooms.each { |classroom| create(:classroom_student, classroom: classroom, student: student) }

        classrooms_from_repo = ClassroomRepository.find_by_student_id(student.id)

        assert_not_nil classrooms_from_repo
        assert_equal 3, classrooms_from_repo.count
        classrooms_from_repo.each do |classroom|
            assert_not_nil classroom.classroom_students.find_by(student_id: student.id)
        end
    end
end