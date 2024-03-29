require 'test_helper'

class ClassroomStudentTest < ActiveSupport::TestCase
    should belong_to(:classroom)
    should belong_to(:student).class_name('User')

    should validate_presence_of(:classroom)
    should validate_presence_of(:student)

    test "student is created when validations passing and association established with classroom and student" do
        classroom = create(:classroom)
        student = create(:user, :student)

        classroom_student = build(:classroom_student, classroom: classroom, student: student)

        assert classroom_student.valid?
    end

    test "student fails to create with validations failing" do
        classroom_student = ClassroomStudent.new

        assert_not classroom_student.valid?
        assert_not_empty classroom_student.errors[:student]
        assert_not_empty classroom_student.errors[:classroom]
    end
end
