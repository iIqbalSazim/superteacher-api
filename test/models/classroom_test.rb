require 'test_helper'

class ClassroomTest < ActiveSupport::TestCase
    should belong_to(:teacher).class_name('User')
    should have_many(:classroom_global_messages).dependent(:destroy)
    should have_many(:classroom_students).dependent(:destroy)
    should have_many(:resources).dependent(:destroy)
    should have_many(:students).class_name('User').through(:classroom_students)

    should validate_presence_of(:teacher)
    should validate_presence_of(:title)
    should validate_presence_of(:subject)
    should validate_presence_of(:class_time)
    should validate_presence_of(:days)

    test "should validate days format" do
        classroom = Classroom.new(
            teacher: users(:math_classroom_teacher),
            title: "Test Classroom",
            subject: "Test Subject",
            class_time: "10:00 AM - 12:00 PM",
            days: ["Monday", "Tuesday", "Wednesday"] # Valid days
        )

        assert classroom.valid?

        invalid_classroom = Classroom.new(
            teacher: users(:math_classroom_teacher),
            title: "Test Classroom",
            subject: "Test Subject",
            class_time: "10:00 AM - 12:00 PM",
            days: ["Monday", "Invalid Day"] 
        )

        assert_not invalid_classroom.valid?
    end
end
